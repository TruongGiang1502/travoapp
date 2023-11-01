String timeWithShortNameMonth(DateTime time){
  String shortMonth;

  switch (time.month){
    case 1:
      shortMonth = 'Jan';
    case 2:
      shortMonth = 'Feb';
    case 3:
      shortMonth = 'Mar';
    case 4:
      shortMonth = 'Apr';
    case 5:
      shortMonth = 'May';
    case 6:
      shortMonth = 'Jun'; 
    case 7:
      shortMonth = 'Jul';
    case 8:
      shortMonth = 'Aug';
    case 9:
      shortMonth = 'Sep';
    case 10:
      shortMonth = 'Oct';
    case 11:
      shortMonth = 'Nov';
    default:
      shortMonth = 'Dec';
  }
  return '$shortMonth ${time.day}, ${time.year}';
}