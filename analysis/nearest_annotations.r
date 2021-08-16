library(GenomicRanges)
library(GenomicFeatures)
library(RColorBrewer)

#Functions to find the nearest gene, cpg island, shore, shelf, etc.
#Each function returns the annotation of the nearest feature + the object with the distances

#find the nearest gene
nearest_gene <- function(object, annotation) {

annotation[!is.na(annotation@elementMetadata$gene_id),] -> anno_gene #include only ranges with a gene annotated to it

distanceToNearest(object, anno_gene)->distance_gene #get distance to nearest gene

return(list(anno_gene, distance_gene))
}


#find the nearest CpG island, shore and shelf, returns dataframe with ranges and colours and distances
nearest_island <- function(object, annotations){


  #find the nearest CpG island to the DMR and only plot if below a certain distance

  #get annotations of each feature separately
  annotations[which(annotations@elementMetadata$type == "rn6_cpg_islands"),]->anno_islands
  annotations[which(annotations@elementMetadata$type == "rn6_cpg_shelves"),]->anno_shelves
  annotations[which(annotations@elementMetadata$type == "rn6_cpg_shores"),]->anno_shores


  distanceToNearest( DMRs2anno[1], anno_islands)->distance_islands #get distance to nearest islands

  #get annotation of nearest island and then find nearest shelf and shore
  anno_islands[distance_islands@to,] -> island

  anno_shelves[follow(island, anno_shelves),] ->shelf_before
  anno_shelves[precede(island, anno_shelves),] ->shelf_after


  anno_shores[follow(island, anno_shores),] ->shore_before
  anno_shores[precede(island, anno_shores),] ->shore_after

  #append all GRanges objects (need to append one at the time, function only appends 2)
  complete_island <- append(shelf_before, append(shore_before, append(island, append(shore_after, shelf_after))))

  #add a meta data column with the colours to add to the

  brewer.pal(3, 'Set1') ->cols
  c(cols[1], cols[2], cols[3], cols[2], cols[1])-> elementMetadata(complete_island)$colours

  return(list(complete_island, distance_islands))
}
