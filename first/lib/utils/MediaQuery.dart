List<double> heightList = [];
List<double> fontSizeList = [];

List<double> getFirstPageMediaHeight(_mediaHeight) {
  if     ( _mediaHeight > 900 ) heightList = [ 563.0 ];
  else if( _mediaHeight > 800 ) heightList = [ 495.0 ];
  else if( _mediaHeight > 700 ) heightList = [ 383.0 ];
  else                          heightList = [ 340.0 ];

  return heightList;
}

List<double> getFirstPageFontSize(_mediaHeight) {
  if( _mediaHeight > 700 ) fontSizeList = [ 20, 30 ];
  else fontSizeList = [ 15, 25 ];

  return fontSizeList;
}

List<double> getNoiseDectectorPageMediaHeight(_mediaHeight) {
  if     ( _mediaHeight > 900 ) heightList = [ 140.0, 270.0, 100.0 ];
  else if( _mediaHeight > 800 ) heightList = [ 120.0, 240.0, 90.0  ];
  else if( _mediaHeight > 700 ) heightList = [ 65.0,  230.0, 10.0  ];
  else                          heightList = [ 45.0,  230.0, 0.0   ];


  return heightList;
}

List<double> getNoiseDectectorPageFontSize(_mediaHeight) {
  if( _mediaHeight > 700 ) fontSizeList = [ 20 ];
  else fontSizeList = [ 15 ];

  return fontSizeList;
}

List<double> getSencondPageHeight(_mediaHeight) {
  if( _mediaHeight > 900 ) heightList = [ 550 ];
  else                     heightList = [ 400 ];

  return heightList;
}