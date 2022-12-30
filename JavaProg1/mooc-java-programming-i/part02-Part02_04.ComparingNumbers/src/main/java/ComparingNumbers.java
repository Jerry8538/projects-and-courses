
import java.util.Scanner;

public class ComparingNumbers {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        int n1 = Integer.valueOf(scanner.nextLine());
        int n2 = Integer.valueOf(scanner.nextLine());
        
        if (n1 > n2) {
            System.out.println(n1 + " is greater than " + n2 + ".");
        } else if (n2 > n1) {
            System.out.println(n1 + " is smaller than " + n2 + ".");
        } else {
            System.out.println(n1 + " is equal to " + n2 + ".");
        }
    }
}
