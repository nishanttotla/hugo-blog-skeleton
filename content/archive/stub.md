+++
authors = []
categories = []
date = "2050-05-31T13:32:52-07:00"
description = ""
draft = false
socialsharing = false
tags = []
title = "Stub"

+++

This page is a stub. It's part of a hack meant to publish an archive page using Hugo. The
archive page contains a list of all the pages across all sections of the website. To see
how it works, check the following files

- `themes/skeleton/layouts/partials/archivelist.html` -- The main condition here that does the magic is `{{ if and (.IsPage) (.Section) (not (eq .Section "archive" )) }}`
- `themes/skeleton/layouts/section/archive.html`