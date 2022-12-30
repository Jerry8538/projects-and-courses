
import java.util.Scanner;

public class AbsoluteValue {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        int n = Integer.valueOf(scanner.nextLine());
        
        if (n < 0) {
            System.out.println(n*-1);
        } else {
            System.out.println(n);
        }
    }
}
