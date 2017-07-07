Skeleton
====

Custom theme based on [Skeleton](http://getskeleton.com).

Uses gulp for minification.

```
$ gulp
```

### Fontello Fonts

Custom fonts from [Fontello](http://fontello.com/) are used on the site. To make changes or add new ones, follow these instructions:

1. Import the file `static/fontello/config.json` on the [Fontello website](http://fontello.com/) to make sure you start with the exact codes present at the time.
2. Add or remove icons, and download folder containing updated fonts.
3. Replace the `static/fontello` folder with the downloaded one.
4. Open `static/fontello/css/fontello.css`. The URLs under `@font-face` will look like `url('../font/fontello.eot?18722301')` by default. Change those to `url('/fontello/font/fontello.eot?18722301')`.
5. In the current directory, re-generate `styles.css` and minify by running `gulp`.
6. That's it. Now the new fonts should be available for use.
