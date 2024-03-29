#Functions to change chromosome names in the rat BiSeq objects so they match the annotation file created with build_annotation.r
#This script can be loaded when wanting to annotate any results/BIseq objects.


change_chr<-function(object){

#substitute chr number by starting with 'chr' to match annotations object
  if(length(seqlevels(object)[grep('^[0-9]*$', seqlevels(object))])>0){
    seqlevels(object)[grep('^[0-9]*$', seqlevels(object))] <- paste0("chr", seqlevels(object)[grep('^[0-9]*$', seqlevels(object))])
  }else{
    print("No numeric chromosome sequences")
  }
#repeat for MT, X and Y
  if(length(seqlevels(object)[grep('MT', seqlevels(object))])>0){
    seqlevels(object)[grep('MT', seqlevels(object))] <- str_replace(seqlevels(object)[grep('MT', seqlevels(object))], 'MT', 'chrM')
  }else{
    print("No mitochondrial sequences")

  }

  if(length(seqlevels(object)[grep('X', seqlevels(object))])>0){
    seqlevels(object)[grep('X', seqlevels(object))] <- str_replace(seqlevels(object)[grep('X', seqlevels(object))], 'X', 'chrX')
  }else{
    print("No X chromosome sequences")
  }

  if(length(seqlevels(object)[grep('Y', seqlevels(object))])>0){
    seqlevels(object)[grep('Y', seqlevels(object))] <- str_replace(seqlevels(object)[grep('Y', seqlevels(object))], 'Y', 'chrY')
  }else{
    print("No Y chromosome sequences")
  }
  return(object)
}



# The unplaced scaffold have a '.1' at the end of the chromosome name. In the annotation file they have a 'chrUn_' at the start and 'v1' at the end. Replace '.1' for 'v1

#Look for each scaffold in the annotation object and replace its name with the one in the annotation object

change_scaffold<-function(object, annotation){

  if(length(seqlevels(object)[grep('[.]1', seqlevels(object))])>0){
    scaffolds <- seqlevels(object)[grep('[.]1', seqlevels(object))]


    for(i in scaffolds){
    	new_scaffold <- seqlevels(annotation)[grep(str_replace(i, '[.]1', ''), seqlevels(annotation))] # look for same name in annotations file
    	seqlevels(object)[grep(i, seqlevels(object))] <- new_scaffold # replace in the data object
    }
  }else{
    print("No scaffold sequences")
  }

  return(object)
}
