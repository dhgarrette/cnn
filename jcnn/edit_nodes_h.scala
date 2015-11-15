val Re = """struct ([A-Za-z]+) : public Node \{""".r
val lines = File("/u/dhg/workspace/cnn/cnn/nodes.h").readLines
writeUsing(File("/u/dhg/Desktop/nodes.h")) { f =>
  while (lines.hasNext) {
    val line = lines.next
    f.wl(line)
    line match {
      case Re(name) => f.wl(s"""  ${name}() : Node() { throw std::runtime_error("The default constructor of ${name} should not be used"); }""")
      case _ => // do nothing
    }
  }
}
