
[![Travis-CI Build Status](https://travis-ci.org/r-gris/rangl.svg?branch=master)](https://travis-ci.org/r-gris/rangl) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/r-gris/rangl?branch=master&svg=true)](https://ci.appveyor.com/project/r-gris/rangl) [![Coverage Status](https://img.shields.io/codecov/c/github/r-gris/rangl/master.svg)](https://codecov.io/github/r-gris/rangl?branch=master)

<!-- README.md is generated from README.Rmd. Please edit that file -->
Tabular storage for spatial data
--------------------------------

The 'rangl' package illustrates some generalizations of GIS-y tasks in R with "tables".

The basic idea is to create "toplogical" objects from a variety of sources including:

-   vector Spatial data, from `sp` and family
-   raster grid data
-   general 3D objects (including `rgl`)
-   `trip objects` (animal tracking data) and other related "trajectory" data
-   model structures for spatially explicit ecosystem models
-   --others to come-- see <https://github.com/mdsumner/spbabel>

The topology comes from two related aspects. The first is decomposing what are usually *paths of coordinates* defining lines or polygons into the more general topological primitives. The second is a de-duplication of shared vertices into a single **vertex pool** that is referenced by primitives. This is not what is always meant when people say "topology" in a GIS context, but the topic is too complex and fragmented to summarize in brief here.

Multiple multi-part objects are decomposed to a set of related, linked tables. Object identity is maintained with attribute metadata and this is carried through to colour and other aesthetics in plots. The nice thing is that the structures used for general visualization correspond to handy structures for a lot of modelling and analyses. It also happens that the easiest way to prove that it works is to plot it, so it's a good place to start, "eye-candy" snubs aside.

Plot methods take those tables and generate the "indexed array" structures needed for 'rgl'. The tables use globally unique IDs to ensure that we can subset and recombine data sets arbitrarily without constantly updating structural indexes. The tables can also be back-ended by whatever database engine is appropriate, so we can leverage that power as we like without having to push through shoe-horn ourselves through someone's definition of how spatial data is supposed to be stored. Analytical methods can either use the graphics structure index model or the relational table model. In this way we get the best of both worlds of "GIS" and "3D models".

Why?
----

There is plenty of evidence around for the need for this kind of approach to data structures, we can see it in PostGIS Topology when simple features is not enough, in geometry generators for QGIS, in coordinate space munching by ggplot2, and in the wonderful discussions of topology and projections by Mike Bostock. This project certainly doesn't solve or unify all aspects, but it has a utility for a wide variety of concerns and I hope this helps spur discussion about the future of spatial data handling generally.

Ongoing design
--------------

The core work for translating "Spatial" classes is done by the unspecialized 'spbabel::map\_table' function.

This is likely to be replaced by a 'primitives()' function that takes any lines or polygons data and returns just the linked edges. Crucially, polygons and lines are described by the same 1D primitives, and this is easy to do. Harder is to generate 2D primitives and for that we rely on [Jonathan Richard Shewchuk's Triangle](https://www.cs.cmu.edu/~quake/triangle.html).

Triangulation is with `RTriangle` package using "constrained mostly-Delaunay Triangulation" from the Triangle library, but could alternatively use `rgl` with its ear clipping algorithm.

(With RTriangle we can set a max area for the triangles, so it can wrap around curves like globes and hills.)

Installation
------------

This package is in active development and will see a number of breaking changes before release.

Also required are packages 'rgl' and 'RTriangle', so first make sure you can install and use these.

``` r
install.packages("rgl")
install.packages("RTriangle")
```

In examples below I use 'graticule', 'trip', and 'rbgm', but these aren't strictly required by the package, only for some examples.

``` r
install.packages("graticule")
install.packages("trip")
install.packages("rbgm")
```

If you are feeling adventurous, 'rangl' can be installed from Github.

``` r
devtools::install_github("r-gris/rangl")
```

Get involved!
-------------

Let me know if you have problems, or are interested in this work. See the issues tab to make suggestions or report bugs.

<https://github.com/r-gris/rangl/issues>

Examples
--------

See the [package vignettes](https://r-gris.github.io/rangl/articles/index.html).

Open topics
-----------

-   single-points are a bit funny, it's wasteful to copy the branches model - needs thought
-   multi-points are also a bit funny, but this will form the basis of input tracking data for some applications
-   UUIDs- unique IDs are not done very well, they are maybe ... 1) not unique enough, 2) over-used for vertices/branches, 3) unnecessary for general storage, maybe we should always flip back to structural *after* merge/transmission operations.

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
