class Setting {

   String lang;
   String favoriteColor;
   bool isDark;

   Setting({this.lang, this.isDark, this.favoriteColor}){
     if(lang==null) lang='en';
     if(favoriteColor==null)favoriteColor='0xff000000';//should be 8bit
     if(isDark==null) isDark=false;
   } 
  
}