@testable import AppBundle
import XCTest

@MainActor
final class FocusCacheTest: XCTestCase {
    override func setUp() async throws { setUpWorkspacesForTests() }

    func testNativeFocusFromAnotherWorkspaceDoesNotChangeFocus() {
        let localWorkspace = Workspace.get(byName: "local")
        let otherWorkspace = Workspace.get(byName: "other")
        let localWindow = TestWindow.new(id: 10001, parent: localWorkspace.rootTilingContainer)
        let otherWindow = TestWindow.new(id: 10002, parent: otherWorkspace.rootTilingContainer)
        XCTAssertTrue(localWindow.focusWindow())

        updateFocusCache(localWindow)
        updateFocusCache(otherWindow)

        XCTAssertEqual(focus.workspace, localWorkspace)
        XCTAssertEqual(focus.windowOrNil, localWindow)
    }
}
