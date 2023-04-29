class ShapeConfiguration {
    float m;
    float n1;
    float n2;
    float n3;
    float a = 1;
    float b = 1; 
    
    public ShapeConfiguration(float n1, float n2, float n3, float m) {
        this.m = floor(m);
        this.n1 = floor(n1);
        this.n2 = floor(n2);
        this.n3 = floor(n3);
    }
    
    public ShapeConfiguration(float n1, float n2, float n3, float m, float a, float b) {
        this.m = m;
        this.n1 = n1;
        this.n2 = n2;
        this.n3 = n3;
        this.a = a;
        this.b = b;
    }
    
    public String print() {
       return "m: " + m + ", n1: " + n1 + ", n2: " + n2 + ", n3: " + n3;
    }
}
