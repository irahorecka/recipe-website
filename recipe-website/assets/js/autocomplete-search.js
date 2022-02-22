const DEFAULTS = {
  maximumItems: 5,
  highlightTyped: false,
  label: 'label',
};

class Autocomplete {
  constructor(field, options) {
    this.field = field;
    this.options = Object.assign({}, DEFAULTS, options);
    this.dropdown = null;

    field.parentNode.classList.add('dropdown');
    field.parentNode.classList.add('mb-4');
    field.setAttribute('data-bs-toggle', 'dropdown');
    field.classList.add('dropdown-toggle');

    const dropdown = ce(`<div class="dropdown-menu"></div>`);
    if (this.options.dropdownClass)
      dropdown.classList.add(this.options.dropdownClass);
    insertAfter(dropdown, field);

    this.dropdown = new bootstrap.Dropdown(field, this.options.dropdownOptions);
  }

  setData(data) {
    this.options.data = data;
    this.renderIfNeeded();
  }

  renderIfNeeded() {
    if (this.createItems() > 0)
      this.dropdown.show();
    else
      this.field.click();
  }

  createItem(lookup, item) {
    let label;
    if (this.options.highlightTyped) {
      const idx = removeDiacritics(item.label)
          .toLowerCase()
          .indexOf(removeDiacritics(lookup).toLowerCase());
      const className = Array.isArray(this.options.highlightClass) ? this.options.highlightClass.join(' ')
        : (typeof this.options.highlightClass == 'string' ? this.options.highlightClass : '');
      label = item.label.substring(0, idx)
        + `<span class="${className}">${item.label.substring(idx, idx + lookup.length)}</span>`
        + item.label.substring(idx + lookup.length, item.label.length);
    } else {
      label = item.label;
    }
    const iconClass = {
      'author': 'fa-user-circle-o',
      'authors': 'fa-user-circle-o',
      'country': 'fa-globe-e',
      'countries': 'fa-globe-e',
      'recipe': 'fa-cutlery',
      'recipes': 'fa-cutlery',
    }
    return ce(`<a href="${item.value.url}#content" class="dropdown-item"><i class="fa ${iconClass[item.value.class]} pe-2" aria-hidden="true"></i>${label}</a>`);
  }

  createItems() {
    const lookup = this.field.value;
    if (lookup.length < this.options.threshold) {
      this.dropdown.hide();
      return 0;
    }

    const items = this.field.nextSibling;
    items.innerHTML = '';

    const keys = Object.keys(this.options.data);

    let count = 0;
    for (let i = 0; i < keys.length; i++) {
      const key = keys[i];
      const entry = this.options.data[key];
      const item = {
          label: this.options.label ? entry[this.options.label] : key,
          value: this.options.value ? entry[this.options.value] : entry
      };

      if (removeDiacritics(item.label).toLowerCase().indexOf(removeDiacritics(lookup).toLowerCase()) >= -1) {
        items.appendChild(this.createItem(lookup, item));
        if (this.options.maximumItems > 0 && ++count >= this.options.maximumItems)
          break;
      }
    }

    this.field.nextSibling.querySelectorAll('.dropdown-item').forEach((item) => {
      item.addEventListener('click', (e) => {
        let dataLabel = e.target.getAttribute('data-label');
        let dataValue = e.target.getAttribute('data-value');

        this.field.value = dataLabel;

        if (this.options.onSelectItem) {
          this.options.onSelectItem({
            value: dataValue,
            label: dataLabel
          });
        }
      })
    });

    return items.childNodes.length;
  }
}

/**
 * @param html
 * @returns {Node}
 */
function ce(html) {
  let div = document.createElement('div');
  div.innerHTML = html;
  return div.firstChild;
}

/**
 * @param elem
 * @param refElem
 * @returns {*}
 */
function insertAfter(elem, refElem) {
  return refElem.parentNode.insertBefore(elem, refElem.nextSibling);
}

/**
 * @param {String} str
 * @returns {String}
 */
function removeDiacritics(str) {
  return str
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '');
}
