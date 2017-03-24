This repository contains code for my [personal website and blog](http://www.nishanttotla.com).

## Installation

Install [Hugo](http://gohugo.io/). The current repo has been tested with Hugo v0.15. You will also need to install the following dependencies:

- [pygments](http://pygments.org/) -- For code blocks to syntax highlight correctly.
- [`gulp`](http://gulpjs.com/) -- For CSS/Javascript minification.

To build locally, run the `start.sh` bash script, or the following command

```
$ hugo server --theme=skeleton --buildDrafts --watch
```
Then open a browser and visit `http://localhost:1313` to see the site.

### Notes

- After making changes to any CSS/Javascript files, you'll need to run `gulp` in the `/themes/skeleton` directory for minimization.
- Custom fonts from [Fontello](http://fontello.com/) are used on the site. Instructions for making changes to those will be added in the near future.
