# anglr dev

* Removed QUAD, hopefully temporarily. 

* Support for rgl's `plot3d` and `as.mesh3d` is now greatly improved, and now
 `tmesh3d()` and `qmesh3d()` are used rather than creating these types
 manually. 

* Now using reproj package instead of proj4 directly. 

* New data sets, `cad_tas` and `cont_tas`. 

* Old `anglr()` function now defunct. 

# anglr 0.4.7

* Added a `TRI` method for `QUAD`. 

* `DEL.SC` now removes duplicate vertices like `DEL.PATH` always did, but triangulation is
 still done per object since we don't yet have edge to path logic required for object classification
 within the mesh. 

* Improved the triangulation and triangulation to edges logic.

* The plot methods for QUAD now maps cell value to colour. 

* new QUAD model, for raster data. By default the raster cell values are treated as
 a fill aesthetic, and used to provide colour on a flat mesh. The `copy_down` method
 for a QUAD requires only one argument will put the cell values on the geometry for z_. 
 This separation is required especially for more general geometries like XYZ geocentric, 
 because the cell value and geometric Z are not necessarily related. 
 
* Now re-exporting the magrittr pipe. 

* Added `gebco1` as a built-in global elevation data set, to avoid 
 reading from GeoTIFF. 

* Internal function `anglr_lines` is now deprecated, and points to 
 the silicate and plot3d approach. 
 
* Added `copy_down` generic to dispatch on `sc` and subclasses, to  
 transfer raw values, object column data, or raster values to vertices. 

* Added `plot3d` methods to (eventually) replace `plot(anglr(x))` and `linemesh with `plot3d(silicate_model)` - currently only `SC` supported
 and plots as (object-grouped) edges. Returns `rgl` form silently. 

* Removed use of maptools wrld_simpl, replaced by in-built `simpleworld`. 

* Big update for new silicate-based approach, thanks to Andreja Stojic for 
 the feeback. 

* New approach for polygons now using pfft package, identifying triangle
 centroids by polygon. 

# anglr 0.4.6

* new "z = " support in `anglr` for a feature name (to copy as a constant) or a raster object (to extract values onto vertices), 
  for now the raster must be in the same coordinate system as the input object

* new `add_normals` argument for plotting triangulations

* rename package (from rangl)

* now faster by relying on silicate for `sf`

# rangl 0.4.5

* release codename Just Work in Master, Dude

* old functions made defunct

* points now have meta table (it was missing), and singular points are now supported

* raster package is now an Import

* added support for RasterLayer

* fixed globe to keep PROJ.4

* quashed a major bug introduced by use of dplyr::distinct, best to use factor unique classifier on character versions of coords

* several cleanup fixes

# rangl 0.3.0

* rename again, main function is called 'rangl', the term 'mesh' is too often used across R 

* rangl method for trip

* fix for spbabel now means MultiPoints are rangl()-able

# rangl 0.2.0

* removed old globe() plot behaviour, this function now just converts coordinates to geocentric XYZ

* added generic "mesh()" function to convert SpatialPolygons, SpatialLines, and
rgl 'mesh3d' objects (only those that use triangle primitives)

* deprecated "tri_mesh" function, replaced by mesh()

* renamed package to 'rangl'

* improved code coverage of tests

* infrastructure and tests for globe

* new function globe

* performance improved for hole finding and removal from mesh

* achieved working package scaffolding

# trimesh 0.1.0

* first release to Github


