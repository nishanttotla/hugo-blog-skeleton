+++
categories = ["Technical"]
date = "2016-03-14T00:52:35-07:00"
description = "Why I decided to get rid of my old WordPress site and use Hugo instead"
draft = false
socialsharing = true
tags = ["web-design", "hugo", "blog"]
title = "Why I Moved to a Static Website"
aliases = ["/articles/why-i-moved-to-static-website/"]

+++

As some of you know, I've maintained a personal website/blog for a few years now. I've always liked writing, because I consider it to be a natural extension of thinking. While I'm not great with words, I do love keeping track of things I learn -- that's really what a blog means to me. Over time, I went through several iterations to find the right platform. Things always revolved around WordPress, and regardless of what I tried, the experience of writing never got much better. What's more, there was actually a huge overhead to log into WordPress, not get turned off by the painfully slow interface, and then finally type a post -- only to require a new plugin for each added functionality, which made the website progressively slower. I tried optimizing using several tricks, but at the end of the day I hated it.

### Static Site Generators

I was familiar with static site generators -- tools that generate your website for you using some basic definitions, but never thought they could work for me. Around two months ago, I started exploring further, and found that the ecosystem had [grown a lot](https://www.staticgen.com/) since I last checked. Still, it seemed like a lot of work with unclear advantages, until [Prakhar](https://twitter.com/prakharsriv9) fully convinced me to take the plunge.

<blockquote class="twitter-tweet tw-align-center" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/nishanttotla">@nishanttotla</a> I whole-heartedly support this! No DB, editing in your fav text-editor and painless + free deployments. It can&#39;t get better.</p>&mdash; Prakhar Srivastav (@prakharsriv9) <a href="https://twitter.com/prakharsriv9/status/697481406956572672">February 10, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

The end result is this website, served using the static site generator [Hugo](https://gohugo.io/), and hosted on Github's servers using Github pages. I built it on top of the hard work already done by Prakhar, and I'm thankful to him for licensing his work generously. My repo is available on <a href="https://github.com/nishanttotla/hugo-blog-skeleton" title="Source code">Github<i class="icon-github-circled"></i></a>, and I appreciate contributions (issues/comments/PRs/anything else). Here's what I've learned so far, and comparisons with WordPress + [BlueHost](https://www.bluehost.com/).

### Advantages of a Static Site

- **Speed** - Static HTML can be loaded really fast, and is easy to cache. By comparison, WordPress uses a database to serve content that adds latency, and caching is much more complex. Faster websites are also more likely to have [better search ranking](https://webmasters.googleblog.com/2010/04/using-site-speed-in-web-search-ranking.html).
- **Security** - WordPress has been known to have several security vulnerabilities, and generally has a wider attack surface since it needs a database and server to work. I'm no security expert, and always worried about exposing my site to attacks. BlueHost in addition constantly sent me emails about security updates, many of which I didn't fully understand or want to care about. By contrast, a static site can be hosted practically anywhere (which for me means more secure locations like Github pages or AWS).
- **Cost** - A HUGE difference! A BlueHost web hosting account cost me about $50 per year, in addition to ~$10 for the domain name. Now I just pay for the domain, while web hosting is free with Github pages.
- **Development Experience** - Damn good! To be honest, BlueHost run their business like a bank, with a clunky website and poor support, and a file manager straight out of the 90s. To run WordPress on top of that is a nightmare. Now, all my content is neatly versioned using Git and safe from corruption. I can write blog posts in markdown syntax on my favorite text editor (including offline), making it that much easier to write them (this was the biggest draw for me). It's also easier for other people to contribute to my blog now.

### Why I chose Hugo

There are many static site generators out there, including some really popular ones like [Jekyll](https://jekyllrb.com/), [Octopress](http://octopress.org/), etc. Hugo is relatively new, with a smaller ecosystem, but has several things going for it.

- It's very easy to install -- just download a single binary and you're ready to go! As a result, Hugo is easier to update too. By comparison, I couldn't get Jekyll to build cleanly at all, and wouldn't want a Ruby mess on my computer.
- Hugo is fast. It generates content much faster and provides live feedback while editing posts locally. While I didn't realize speed was a big deal initially, I can't imagine how frustrating it would be if each change I made took several seconds (or more) to render.

Given that Hugo is relatively new, it might take more work to get what you want. It also lacks a plugin system. But none of these were problems for me, and overall I've been very happy with my decision.

### Static Sites may not be for Everyone

All that said, if this got you excited, and you want to build your own static site, there are a few caveats to consider.

- Creating a good static site is likely to be more work, and takes a certain amount of comfort with web design. You also need to set up your own workflow which might be hard if you're unfamiliar with programming tools.
- Static websites won't offer full dynamic functionality the way a WordPress site can, so you need to think about what you really need.
- The overall writing experience might not appeal to you after all, if you prefer using WYSIWYG editors and writing tools (although considering the power of static site generators and modern text editors, I'm not unhappy).
- It can be difficult to use other devices to write posts, depending on how complex it is to set up the development environment. Hugo makes it easy, but there can still be challenges with versioning, or when extra tools are needed. At the very least, editing on the phone will be difficult (unlike WordPress).

### In Conclusion

I don't have much more to say, except that to write a blog post now, all I need to do is type
```
$ hugo new blog/post-slug.md
```
in my terminal, and I'm ready to start editing! It's great for taking notes, quickly recording ideas, and eventually sharing them as blog posts, which only takes a simple `git push`. This for me is the biggest win!

Please feel free to report any issues in the comments, or on [Github](https://github.com/nishanttotla/hugo-blog-skeleton). I'm happy to help if you want to set up your own static site. It's a lot of fun! 😸