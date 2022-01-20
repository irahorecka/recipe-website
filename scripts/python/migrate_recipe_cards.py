"""
For migrating recipe summaries in content/contents.lr (root)
to various directories, depending on CLI arguments.

E.g. move items based on:
- Country of origin
- Author
- Meal
"""

from pathlib import Path

LEKTOR_ROOT_DIR = project_dir = (
    Path(__file__).parent.resolve().parent.parent.absolute() / "recipe-website"
)
RECIPE_FLOWBLOCK = "#### recipe ####"


def copy_author_recipes(author_lr_path, recipes_lr_path):  # list, str
    author_page = [get_author_bio(author_lr_path)]
    author_url = get_author_url(author_lr_path)
    author_page.extend(get_author_recipes(author_url, recipes_lr_path))
    with open(author_lr_path, "w") as file:
        file.writelines(author_page)


def get_author_bio(author_lr_path):
    contents = get_contents_lektor_file(author_lr_path)
    return contents.split(RECIPE_FLOWBLOCK)[:1].pop()


def get_author_url(author_lr_path):
    return "/".join(str(author_lr_path).split("/")[-3:-1])


def get_author_recipes(author_url, recipes_lr_path):
    contents = get_contents_lektor_file(recipes_lr_path)
    # Split contents by recipe header.
    recipes = contents.split(RECIPE_FLOWBLOCK)[1:]
    for recipe in recipes:
        if is_recipe_by_author(author_url, recipe):
            yield RECIPE_FLOWBLOCK + recipe


def is_recipe_by_author(author_url, recipe):
    # sourcery skip: inline-immediately-returned-variable
    recipe_author_url = get_value_from_lr_content(recipe, "author_url: ")
    if author_url == recipe_author_url:
        return True
    return "/" + author_url == recipe_author_url


def get_value_from_lr_content(content, key):
    content_start_idx = content.find(key)
    content_end_idx = content[content_start_idx:].find("\n") + content_start_idx
    content_row = content[content_start_idx:content_end_idx]
    return content_row[len(key) :].strip()


def get_contents_lektor_file(filepath):
    """Returns contents of contents Lektor file as string"""
    with open(filepath, "r") as file:
        contents = file.readlines()
    return "".join(contents)


if __name__ == "__main__":
    content_path = LEKTOR_ROOT_DIR / "content"
    recipe_content = content_path / "contents.lr"
    author_content = content_path / "author" / "ira-horecka" / "contents.lr"
    copy_author_recipes(author_content, recipe_content)
