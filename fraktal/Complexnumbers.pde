public static class Complexnumbers {
  
  private double re, im;
  
  public Complexnumbers() {
    re = 0;
    im = 0;
  }
  
  public Complexnumbers(double re_, double im_) {
    re = re_;
    im = im_;
  }
  
  public double getRe() {
    return re;
  }
  
  public double getIm() {
    return im;
  }
  
  void setRe(double re_) {
    re = re_;
  }
  
  void setIm(double im_) {
    im = im_;
  }
  
  public static Complexnumbers cadd(Complexnumbers z1, Complexnumbers z2){
    return new Complexnumbers( z1.re + z2.re, z1.im + z2.im);
  }

  public static Complexnumbers csub(Complexnumbers z1, Complexnumbers z2){
    return new Complexnumbers(z1.re - z2.re, z1.im - z2.im);
  }

  public static Complexnumbers cdiv(Complexnumbers z1, Complexnumbers z2){
    double l2z2 = z2.getRe() * z2.getRe() + z2.getIm() * z2.getIm();
    return new Complexnumbers(((z1.getRe() * z2.getRe() + z1.getIm() * z2.getIm())/l2z2),((-z1.getRe() * z2.getIm() + z1.getIm() * z2.getRe())/l2z2));
  }
  
  public static Complexnumbers cmul(Complexnumbers z1, Complexnumbers z2) {
    return new Complexnumbers((z1.getRe() * z2.getRe() - z1.getIm() * z2.getIm()),(z1.getRe() * z2.getIm() + z1.getIm() * z2.getRe()));
  }
  
  public static Complexnumbers cmulfactor(Complexnumbers z1, double factor) {
    return new Complexnumbers((z1.getRe() * factor), (z1.getIm() * factor));
  }

  public static Complexnumbers cpow(Complexnumbers z1, double z2){
    double v1 = pow((float)z1.getRe(), (float)z2);
    double v2 = pow((float)z1.getIm(), (float)z2);
    return new Complexnumbers( v1, v2);
  }

  public String toString() {
    return "(" + re + "," + im + ")";
  }
  
}
