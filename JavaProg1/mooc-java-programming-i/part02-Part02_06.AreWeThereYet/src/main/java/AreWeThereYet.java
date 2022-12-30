
import java.util.Scanner;

public class AreWeThereYet {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        int input = 0;
        
        while (input != 4) {
            System.out.println("Give a number:");
            input = Integer.valueOf(scanner.nextLine());
        }
    }
}
