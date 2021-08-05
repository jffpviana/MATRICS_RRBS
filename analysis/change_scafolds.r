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
