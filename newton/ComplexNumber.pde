
class ComplexNumber {
  final double r;
  final double i;

  ComplexNumber(double r, double i) {
    this.r = r;
    this.i = i;
  }

  String toString() {
    return this.r + " + " + this.i;
  }

  double abs() {
    return Math.hypot(this.r, this.i);
  }

  ComplexNumber plus(ComplexNumber other) {
    return new ComplexNumber(this.r + other.r, this.i + other.i);
  }

  ComplexNumber plus(double other) {
    return plus(new ComplexNumber(other, 0));
  }


  ComplexNumber minus(ComplexNumber other) {
    return new ComplexNumber(this.r - other.r, this.i - other.i);
  }

  ComplexNumber minus(double other) {
    return minus(new ComplexNumber(other, 0));
  }

  ComplexNumber times(ComplexNumber other) {
    double new_r = this.r * other.r - this.i * other.i;
    double new_i = this.r * other.i + this.i * other.r;
    return new ComplexNumber(new_r, new_i);
  }

  ComplexNumber times(double other) {
    return times(new ComplexNumber(other, 0));
  }

  ComplexNumber pow(double p) {
    double log_r = Math.log(Math.sqrt(this.r * this.r + this.i * this.i));
    double log_i = Math.atan2(this.i, this.r);
    double p_log_r = p * log_r;
    double p_log_i = p * log_i;
    double e_p_log_r = Math.exp(p_log_r);
    return new ComplexNumber(e_p_log_r * Math.cos(p_log_i), e_p_log_r * Math.sin(p_log_i));
  }

  ComplexNumber divideBy(ComplexNumber other) {
    double denom = other.r * other.r + other.i * other.i;
    return this.times(new ComplexNumber(other.r / denom, -other.i / denom));
  }

  ComplexNumber divideBy(double other) {
    return divideBy(new ComplexNumber(other, 0));
  }

  ComplexNumber round(int dec) {
    double mult = Math.pow(10, dec);
    return new ComplexNumber(Math.round(this.r * mult)/ mult, Math.round(this.i * mult)/ mult);
  }
}
