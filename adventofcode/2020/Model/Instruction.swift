struct Instruction {
  enum InstructionType: String {
    case acc = "acc"
    case jmp = "jmp"
    case nop = "nop"
  }

  var type: InstructionType
  let amount: Int

  static func parse(_ string: String) -> Self {
    let parts = string.components(separatedBy: " ")

    return Instruction(type: InstructionType(rawValue: parts[0])!, amount: Int(parts[1])!)
  }
}
