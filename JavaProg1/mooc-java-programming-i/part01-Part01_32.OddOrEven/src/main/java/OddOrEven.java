
import java.util.Scanner;

public class OddOrEven {

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);

        System.out.println("Give a number:");
        int n = Integer.valueOf(scan.nextLine());
        
        if (n % 2 == 0) {
            System.out.println("Number " + n + " is even.");
        } else {
            System.out.println("Number " + n + " + is odd.");
        }
    }
}
