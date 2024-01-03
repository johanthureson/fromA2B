import XCTest

struct APIManagerMock: APIManagerProtocol {
  func perform(_ request: RequestProtocol, authToken: String) async throws -> Data {
    return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
  }
}
