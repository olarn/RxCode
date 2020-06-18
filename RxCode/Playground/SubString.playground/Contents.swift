extension String {
	func getSubString(from: Int, to: Int) -> Substring {
		let start = self.index(self.startIndex, offsetBy: from)
		let end   = self.index(self.startIndex, offsetBy: to)
		return self[start..<end]
	}
}

print("x".getSubString(from: 0, to: 2))
