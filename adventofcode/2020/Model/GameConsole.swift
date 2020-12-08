struct GameConsole {
  let instructions: [Instruction]
  let tolerance: Int

  init(instructions: [Instruction], tolerance: Int = 1) {
    self.instructions = instructions
    self.tolerance = tolerance
  }

  func run(
    _ i: Int = 0,
    _ accumulated: Int = 0,
    _ visited: inout Set<Int>,
    _ fixed: Int = 0
  ) -> Int? {
    if i >= instructions.count {
      return accumulated
    }

    if visited.contains(i) {
      return nil
    }

    let instruction = instructions[i]
    visited.insert(i)

    switch instruction.type {
    case .acc:
      return run(i + 1, accumulated + instruction.amount, &visited, fixed)
    case .jmp:
      let response = run(i + instruction.amount, accumulated, &visited, fixed)
      return response == nil && fixed < tolerance
        ? run(i + 1, accumulated, &visited, fixed + 1)
        : response
    case .nop:
      let response = run(i + 1, accumulated, &visited, fixed)
      return response == nil && fixed < tolerance
        ? run(i + instruction.amount, accumulated, &visited, fixed + 1)
        : response
    }
  }
}
