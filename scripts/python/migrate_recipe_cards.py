"""
For migrating recipe summaries in content/contents.lr (root)
to various directories, depending on CLI arguments.

E.g. move items based on:
- Country of origin
- Author
- Meal
"""

from pathlib import Path


def read_contents_lektor_file(filepath):
    """Returns contents of contents Lektor file as string"""
    with open(filepath, "r") as file:
        contents = file.readlines()
    return "".join(contents)


def main(contents_lr_path):
    contents = read_contents_lektor_file(contents_lr_path)
    # Split contents by recipe header.
    recipes = list(contents.split("#### recipe ####"))[1:]
    for recipe in recipes:
        print(recipe)
        # Plug in logic to: 1. filter content and 2. write filtered content to file


if __name__ == "__main__":
    project_dir = Path(__file__).parent.resolve().parent.parent.absolute() / "recipe-website"
    content_dir = project_dir / "content"
    # Main recipe content - every recipe summary should reside here
    main(content_dir / "contents.lr")
