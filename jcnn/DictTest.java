import edu.cmu.cs.clab.cnn.Dict;

public class DictTest {
  static {
    try {
      System.loadLibrary("jcnn");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load. " + e);
      System.exit(1);
    }
  }

  public static void main(String argv[]) {
    System.out.println("hi");
    Dict d = new Dict();
    d.Convert("a");
    d.Convert("dog");
    d.Convert("walks");
    System.out.println(d.size());
    System.out.println(d.Convert("dog"));
    System.out.println(d.Convert("walks"));
  }
}

