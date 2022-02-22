// DESKTOP SEARCH HANDLER
const desktopField = document.getElementById('desktop-input');
const desktopAC = new Autocomplete(desktopField, {
    data: [{label: "Homepage", url: "/"}],
    maximumItems: 5,
    threshold: 1,
});
desktopAC.dropdown._menu.hidden = true;
addInputHandler(desktopField, desktopAC);
addClickHandler(desktopField, desktopAC);
addKeyDownHandler(desktopField, desktopAC);

// MOBILE SEARCH HANDLER
const mobileField = document.getElementById('mobile-input');
const mobileAC = new Autocomplete(mobileField, {
    data: [{label: "Homepage", url: "/"}],
    maximumItems: 5,
    threshold: 1,
});
mobileAC.dropdown._menu.hidden = true;
addInputHandler(mobileField, mobileAC);
addClickHandler(mobileField, mobileAC);
addKeyDownHandler(mobileField, mobileAC);


function addInputHandler(e, ac) {
    e.addEventListener('input', function(e) {
        updateSearch(e, ac);
    });
}

function addClickHandler(e, ac) {
    e.addEventListener('click', (e) => {
        if (ac.createItems() === 0) {
            e.stopPropagation();
            ac.dropdown._menu.hidden = true;
        }
  });
}

function addKeyDownHandler(e, ac) {
    e.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            // Don't search if input field is empty
            if (ac.field.value === "") {
                return;
            }
            ac.dropdown._menu.hidden = true;
            // Allow user to select top selection if search results found
            let foundResults = updateSearch(e, ac);
            if (foundResults)
                ac.dropdown._menu.children[0]?.click();
            return;
        }
        if (e.key === 'Escape') {
          ac.dropdown._menu.hidden = true;
          return;
        }
    });
}

function updateResults (ac, results, store) {
    if (results.length) {
        let resultList = [];
        // Iterate and build result list elements
        for (const n in results) {
            const item = store[results[n].ref];
            resultList.push(item);
        }
        ac.setData(resultList);
    }
}

function updateSearch(e, ac) {
    // Returns false if search failed and true if search successful
    // Escape space(s) if found in query
    const query = e.target.value.replace(/ /g,"\\ ");
    if (query.length === 0) {
        ac.dropdown._menu.hidden = true;
        return false;
    }
    const idx = lunr(function () {
        this.ref('id');
        this.field('label', {
            boost: 15
        });
        this.field('tags', {
            boost: 10
        });
        for (const key in window.store) {
            this.add({
                id: key,
                label: window.store[key].label,
                tags: window.store[key].category,
            });
        }
    })
    // Perform wildcard and fuzzy match search
    const results = idx.search(`${query}* ${query}~2`);
    // No results - hide dropdown menu
    if (results.length === 0) {
        return false;
    }
    ac.dropdown._menu.hidden = false;
    updateResults(ac, results, window.store);
    return true;
}
