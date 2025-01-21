
validInput (String? val , int min , int max  ){

   if ( val==null || val==""){
    return "can't be emptyً";
  }

  if (val!=null && val.length<min){
    return "can't be less than $min letters";
  }

  if (val!=null && val.length>max){
    return "can't be more than $max letters";
  }
}