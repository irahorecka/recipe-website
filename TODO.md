# Recipe Website TODO file

This is a TODO.md file for the Recipe Website.

### Todo

- [ ] Add more gallery (photoswipe-like) photos throughout the recipe (e.g., step-by-step instruction images)
- [ ] Ensure all tags are closed in every HTML file
- [ ] Update /about page
- [ ] Add error pages
- [ ] Add lettering to logo
- [ ] NICE-TO-HAVE :: Ability to query ingredients in search bar
- [ ] POTENTIAL FEATURE :: Ingredients page for uncommon ingredients
- [ ] Add recipes
  - [ ] Johnfavour's chicken
  - [ ] Chinese sausage fried rice

### In Progress

- [ ] Give functionality to 'Surprise me!' button

### Done ✓

- [x] Compartmentalize assets/images/ folder
- [x] Update logo
- [x] Fix sidebar and navbar format
  - [x] Update hyperlinks
- [x] Add search bar to sidebar
  - [x] Find frontend library for static page searching
  - [x] Enable fast auto-complete suggestions when searching
  - [x] Enable general querying capabilities
  - [x] Ensure functionality for both desktop and mobile sidebars
- [x] Establish a good href ID link to page content (especially helpful for mobile devices)
- [x] Add humans.txt page
- [x] BUG :: Persistent lunr features even with wrong keyword
  - E.g., Type 'Anna' --> (feaure) 'Anna Axakova' --> Delete 'Anna' then type '/' (no feature) --> Press ENTER --> Route to Anna's page
- [x] BUG :: Incorrect placement of search dropdown menu if parsing failed in initial search followed by good search
  - E.g., Type '/Ira' --> (hidden feature) --> Delete '/Ira' then type 'Ira' (feature) --> 'Ira' in dropdown item located @ bottom of page
- [x] Create model field for search tags for every contents.lr file
- [x] Add recipes
  - [x] Japanese mapo tofu
  - [x] Sautéed shishito peppers
