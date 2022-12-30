
import java.util.Scanner;

public class GiftTax {

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        
        System.out.println("Value of the gift?");
        int v = Integer.valueOf(scan.nextLine());
        
        int minTax = 0;
        double rate = 0;
        int taxableAmt = 0;
        
        if (v < 5000) {
            System.out.println("No tax!");
            
        } else if (v < 25000) {
            minTax = 100;
            rate = 0.08;
            taxableAmt = v - 5000;
            System.out.println("Tax: " + (minTax + (taxableAmt * rate)));
            
        } else if (v < 55000) {
            minTax = 1700;
            rate = 0.1;
            taxableAmt = v - 25000;
            System.out.println("Tax: " + (minTax + (taxableAmt * rate)));
            
        } else if (v < 200000) {
            minTax = 4700;
            rate = 0.12;
            taxableAmt = v - 55000;
            System.out.println("Tax: " + (minTax + (taxableAmt * rate)));
            
        } else if (v < 1000000) {
            minTax = 22100;
            rate = 0.15;
            taxableAmt = v - 200000;
            System.out.println("Tax: " + (minTax + (taxableAmt * rate)));
            
        } else {
            minTax = 142100;
            rate = 0.17;
            taxableAmt = v - 1000000;
            System.out.println("Tax: " + (minTax + (taxableAmt * rate)));
        }
    }
}
