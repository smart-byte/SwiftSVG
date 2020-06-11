import XCTest
import Swift2D
@testable import SwiftSVG

final class PathDataTests: XCTestCase {
    
    static var allTests = [
        ("testDataFormatAppleSymbols", testDataFormatAppleSymbols),
        ("testDataFormatPixelmatorPro", testDataFormatPixelmatorPro),
        ("testDataFormatSketch", testDataFormatSketch),
        ("testRelativePath", testRelativePath),
        ("testCompareFormats", testCompareFormats),
        ("testSingleValueProcessing", testSingleValueProcessing),
    ]
    
    func testDataFormatAppleSymbols() throws {
        let pathData = "M 11.709 2.91016 C 17.1582 2.91016 21.6699 -1.60156 21.6699 -7.05078 " +
        "C 21.6699 -12.4902 17.1484 -17.0117 11.6992 -17.0117 C 6.25977 -17.0117 1.74805 -12.4902 1.74805 -7.05078 " +
        "C 1.74805 -1.60156 6.26953 2.91016 11.709 2.91016 Z M 11.709 1.25 C 7.09961 1.25 3.41797 -2.44141 3.41797 -7.05078 " +
        "C 3.41797 -11.6504 7.08984 -15.3516 11.6992 -15.3516 C 16.3086 -15.3516 20 -11.6504 20.0098 -7.05078 " +
        "C 20.0195 -2.44141 16.3184 1.25 11.709 1.25 Z M 11.6895 -2.41211 C 12.207 -2.41211 12.5195 -2.77344 12.5195 -3.33984 " +
        "L 12.5195 -6.23047 L 15.5762 -6.23047 C 16.123 -6.23047 16.5039 -6.51367 16.5039 -7.03125 " +
        "C 16.5039 -7.55859 16.1426 -7.86133 15.5762 -7.86133 L 12.5195 -7.86133 L 12.5195 -10.9277 " +
        "C 12.5195 -11.5039 12.207 -11.8555 11.6895 -11.8555 C 11.1719 -11.8555 10.8789 -11.4844 10.8789 -10.9277 " +
        "L 10.8789 -7.86133 L 7.83203 -7.86133 C 7.26562 -7.86133 6.89453 -7.55859 6.89453 -7.03125 " +
        "C 6.89453 -6.51367 7.28516 -6.23047 7.83203 -6.23047 L 10.8789 -6.23047 L 10.8789 -3.33984 " +
        "C 10.8789 -2.79297 11.1719 -2.41211 11.6895 -2.41211 Z"
        
        let path = Path(data: pathData)
        let commands = try path.commands()
        XCTAssertEqual(commands.count, 30)
        XCTAssertEqual(commands.filter({ $0.hasPrefix(.move) }).count, 3)
        XCTAssertEqual(commands.filter({ $0.hasPrefix(.close) }).count, 3)
    }
    
    func testDataFormatPixelmatorPro() throws {
        let pathData = "M96.083 307 C82.23 307 71 295.77 71 281.917 L71 145.75 C71 131.899 82.23 120.667 96.083 120.667 " +
        "96.083 120.667 109.056 120.667 128.522 120.667 128.522 92.001 151.578 92 155.425 92 185.826 92 210.976 92.056 243.595 92.056 " +
        "252.61 92.056 271.87 95.585 271.87 120.667 291.116 120.667 303.916 120.667 303.916 120.667 317.768 120.667 329 131.899 329 145.75 " +
        "L329 281.917 C329 295.77 317.768 307 303.916 307 L96.083 307 Z M200 264 C231.663 264 257.333 238.332 257.333 206.667 " +
        "257.333 175.004 231.663 149.334 200 149.334 168.335 149.334 142.666 175.004 142.666 206.667 142.666 238.332 168.335 264 200 264 Z " +
        "M200 235.334 C184.167 235.334 171.333 222.499 171.333 206.667 171.333 190.836 184.167 178 200 178 " +
        "215.831 178 228.667 190.836 228.667 206.667 228.667 222.499 215.831 235.334 200 235.334 Z"
        
        let path = Path(data: pathData)
        let commands = try path.commands()
        XCTAssertEqual(commands.count, 26)
        XCTAssertEqual(commands.filter({ $0.hasPrefix(.move) }).count, 3)
        XCTAssertEqual(commands.filter({ $0.hasPrefix(.close) }).count, 3)
    }
    
    func testDataFormatSketch() throws {
        let pathData = "M22,40.333 C11.875,40.333 3.667,32.125 3.667,22 C3.667,21.988 3.668,21.976 3.668,21.964 " +
        "L14.481,21.964 L19.74,34.229 L25.544,18.92 L27.31,21.964 L33,21.964 C34.013,21.964 34.833,21.143 34.833,20.131 " +
        "C34.833,19.118 34.013,18.297 33,18.297 L29.422,18.297 L24.849,10.413 L19.531,24.437 L16.898,18.297 " +
        "L4.041,18.297 C5.754,9.947 13.143,3.666 22,3.666 C32.125,3.666 40.333,11.875 40.333,22 " +
        "C40.333,32.125 32.125,40.333 22,40.333 M22,0 C9.85,0 0,9.85 0,22 C0,34.15 9.85,44 22,44 " +
        "C34.15,44 44,34.15 44,22 C44,9.85 34.15,0 22,0"
        
        let path = Path(data: pathData)
        let commands = try path.commands()
        XCTAssertEqual(commands.count, 24)
        XCTAssertEqual(commands.filter({ $0.hasPrefix(.move) }).count, 2)
        XCTAssertEqual(commands.filter({ $0.hasPrefix(.close) }).count, 1)
    }
    
    func testRelativePath() throws {
        let absolute = "M217.074 360.93 C145.835 360.93 88.022 303.209 88.022 231.958 88.022 160.578 145.835 102.899 217.074 102.899 288.375 102.899 346.116 160.578 346.116 231.958 346.116 303.209 288.375 360.93 217.074 360.93 M217.074 38.459 C110.278 38.459 23.675 125.084 23.675 231.958 23.675 338.75 110.278 425.348 217.074 425.348 323.916 425.348 410.655 338.75 410.655 231.958 410.655 125.084 323.916 38.459 217.074 38.459 Z"
        let relative = "M217.074,360.93c-71.239,0-129.052-57.721-129.052-128.972c0-71.38,57.813-129.059,129.052-129.059c71.301,0,129.042,57.679,129.042,129.059C346.116,303.209,288.375,360.93,217.074,360.93 M217.074,38.459c-106.796,0-193.399,86.625-193.399,193.499c0,106.792,86.603,193.39,193.399,193.39c106.842,0,193.581-86.598,193.581-193.39C410.655,125.084,323.916,38.459,217.074,38.459z"
        
        let absolutePath = Path(data: absolute)
        let relativePath = Path(data: relative)
        
        let absoluteCommands = try absolutePath.commands()
        let relativeCommands = try relativePath.commands()
        
        XCTAssertEqual(absoluteCommands.count, relativeCommands.count)
        
        for i in 0..<absoluteCommands.count {
            XCTAssertRoughlyEqual(absoluteCommands[i], relativeCommands[i])
        }
    }
    
    func testCompareFormats() throws {
        let sketchFormat = "M49.231,365 C49.231,365 42.771,306.868 98.187,294.192 C153.604,281.515 170.121,279.704 173.864,267.482 " +
        "C177.606,255.26 178.315,231.869 178.315,231.869 C178.315,231.869 160.526,215.862 152.719,195.979 " +
        "C144.912,176.095 142.703,164.818 142.703,164.818 C142.703,164.818 136.176,163.653 133.939,152.019 " +
        "C131.702,140.386 123.234,128.367 124.897,120.024 C126.867,110.139 133.383,116.129 133.383,116.129 " +
        "C133.383,116.129 133.073,77.174 154.806,56.45 C159.22,52.241 173.586,53.807 173.586,53.807 " +
        "C173.586,53.807 175.811,36 211.146,36 C241.413,36 262.37,47.578 275.555,72.865 C288.739,98.152 284.875,115.572 284.875,115.572 " +
        "C284.875,115.572 294.131,110.734 294.056,124.475 C293.981,138.216 286.348,146.528 285.431,151.88 " +
        "C284.515,157.233 283.719,164.773 276.667,165.374 C273.99,177.367 273.57,185.877 263.313,203.212 " +
        "C253.056,220.548 240.498,231.591 240.498,231.591 C240.498,231.591 240.289,257.337 244.811,267.204 " +
        "C249.333,277.071 318.742,294.869 336.207,307.685 C353.671,320.501 351.927,364.999 351.927,364.999 L49.231,365 Z"
        
        let appleSymbolsFormat = "M 49.231 365 C 49.231 365 42.771 306.868 98.187 294.192 C 153.604 281.515 170.121 279.704 173.864 267.482 " +
        "C 177.606 255.26 178.315 231.869 178.315 231.869 C 178.315 231.869 160.526 215.862 152.719 195.979 " +
        "C 144.912 176.095 142.703 164.818 142.703 164.818 C 142.703 164.818 136.176 163.653 133.939 152.019 " +
        "C 131.702 140.386 123.234 128.367 124.897 120.024 C 126.867 110.139 133.383 116.129 133.383 116.129 " +
        "C 133.383 116.129 133.073 77.174 154.806 56.45 C 159.22 52.241 173.586 53.807 173.586 53.807 " +
        "C 173.586 53.807 175.811 36 211.146 36 C 241.413 36 262.37 47.578 275.555 72.865 C 288.739 98.152 284.875 115.572 284.875 115.572 " +
        "C 284.875 115.572 294.131 110.734 294.056 124.475 C 293.981 138.216 286.348 146.528 285.431 151.88 " +
        "C 284.515 157.233 283.719 164.773 276.667 165.374 C 273.99 177.367 273.57 185.877 263.313 203.212 " +
        "C 253.056 220.548 240.498 231.591 240.498 231.591 C 240.498 231.591 240.289 257.337 244.811 267.204 " +
        "C 249.333 277.071 318.742 294.869 336.207 307.685 C 353.671 320.501 351.927 364.999 351.927 364.999 L 49.231 365 Z"
        
        let pixelmatorFormat = "M49.231 365 C49.231 365 42.771 306.868 98.187 294.192 153.604 281.515 170.121 279.704 173.864 267.482 " +
        "177.606 255.26 178.315 231.869 178.315 231.869 178.315 231.869 160.526 215.862 152.719 195.979 " +
        "144.912 176.095 142.703 164.818 142.703 164.818 142.703 164.818 136.176 163.653 133.939 152.019 " +
        "131.702 140.386 123.234 128.367 124.897 120.024 126.867 110.139 133.383 116.129 133.383 116.129 " +
        "133.383 116.129 133.073 77.174 154.806 56.45 159.22 52.241 173.586 53.807 173.586 53.807 173.586 53.807 " +
        "175.811 36 211.146 36 241.413 36 262.37 47.578 275.555 72.865 288.739 98.152 284.875 115.572 284.875 115.572 " +
        "284.875 115.572 294.131 110.734 294.056 124.475 293.981 138.216 286.348 146.528 285.431 151.88 " +
        "284.515 157.233 283.719 164.773 276.667 165.374 273.99 177.367 273.57 185.877 263.313 203.212 " +
        "253.056 220.548 240.498 231.591 240.498 231.591 240.498 231.591 240.289 257.337 244.811 267.204 " +
        "249.333 277.071 318.742 294.869 336.207 307.685 353.671 320.501 351.927 364.999 351.927 364.999 L49.231 365 Z"
        
        let sketchPath = Path(data: sketchFormat)
        let appleSymbolsPath = Path(data: appleSymbolsFormat)
        let pixelmatorPath = Path(data: pixelmatorFormat)
        
        let sketchCommands = try sketchPath.commands()
        let appleSymbolsCommands = try appleSymbolsPath.commands()
        let pixelmatorCommands = try pixelmatorPath.commands()
        
        XCTAssertEqual(sketchCommands.count, appleSymbolsCommands.count)
        XCTAssertEqual(appleSymbolsCommands.count, pixelmatorCommands.count)
        XCTAssertEqual(pixelmatorCommands.count, sketchCommands.count)
        
        for i in 0..<sketchCommands.count {
            XCTAssertRoughlyEqual(sketchCommands[i], appleSymbolsCommands[i])
            XCTAssertRoughlyEqual(appleSymbolsCommands[i], pixelmatorCommands[i])
            XCTAssertRoughlyEqual(pixelmatorCommands[i], sketchCommands[i])
        }
    }
    
    func testSingleValueProcessing() throws {
        let data = "M170.488 118.443h-.537v2.368h.322v-1.936l.752 1.936h.43l.645-1.936v1.936h.429v-2.368h-.644l-.645 1.83-.752-1.83z"
        
        let path = Path(data: data)
        let commands = try path.commands()
        commands.forEach({ print($0) })
        XCTAssertEqual(commands.count, 15)
    }
}
