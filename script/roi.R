library(terra)

poly <- vect("script/data/full_labels.geojson")
ras <- rast("script/data/win2025_dl.tif")

pol_proj <- project(poly, crs(ras))

writeVector(pol_proj, "script/data/full_labels_proj.gpkg",
            overwrite = TRUE)

# Cropping tessera --------------------------------------------------------

r1 <- rast("script/data/tessera_2024_lat-0.35_lon35.25.tif")
r2 <- rast("script/data/tessera_2024_lat-0.35_lon35.35.tif")
r3 <- rast("script/data/tessera_2024_lat-0.45_lon35.25.tif")
r4 <- rast("script/data/tessera_2024_lat-0.45_lon35.35.tif")

v <- vect("script/data/roi.shp")
v <- project(v, crs(r1))

r1 <- crop(r1, v, mask = T)
r2 <- crop(r2, v, mask = T)
r3 <- crop(r3, v, mask = T)
r4 <- crop(r4, v, mask = T)

r1_r2 <- merge(r1, r2)
r3_r4 <- merge(r3, r4)

merged <- merge(r1_r2, r3_r4)

writeRaster(merged, "script/data/tessera_merged.tif")