//
//  PedometerServiceTest.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import XCTest
@testable import MyStepsPal

final class PedometerServiceTests: XCTestCase {
    
    var mockPedometer: MockPedometer!
    var subject: PedometerService!
    
    //MARK: - Setup and Tear Down
    override func setUpWithError() throws {
        super.setUp()
        mockPedometer = MockPedometer()
        subject = PedometerService(pedometer: mockPedometer)
    }
    override func tearDownWithError() throws {
        subject = nil
        super.tearDown()
    }

    
    //MARK: - Test RetrieveLivePedometerData()
    func testRetrieveLivePedometerData_stepCountingUnavailable_throwsError() {
       //GIVEN
       mockPedometer.isAvailableForDevice = false
       
       //WHEN THEN
       XCTAssertThrowsError(
          try subject.startLivePedometerData(withHandler: { pedometerData, error in
          })
       )
    }
    func testRetrieveLivePedometerData_permissionDenied_throwsError() {
       //GIVEN
       mockPedometer.permissionIsAuthorizedByUser = false
       
       //WHEN THEN
       XCTAssertThrowsError(
          try subject.startLivePedometerData(withHandler: { pedometerData, error in
          })
       )
    }
    func testRetrieveLivePedometerData_pedometerHasError_recievesError() throws {
       //GIVEN
       let expectation = expectation(description: "Step Service passes some error from Pedometer")
       mockPedometer.livePedometerError_stubbed = "Error with live pedometer data"
       
       //WHEN
       try subject.startLivePedometerData { pedometerData, error in
          
          //THEN
          XCTAssertNil(pedometerData)
          XCTAssertNotNil(error)
          expectation.fulfill()
       }
       
       wait(for: [expectation], timeout: 1)
    }
    func testRetrieveLivePedometerData_pedometerHasData_receivesData() throws {
       //GIVEN
       let expectation = expectation(description: "Step Service passes some data from Pedometer")
       mockPedometer.livePedometerData_stubbed = Fixtures.validPedometerDatum
       
       //WHEN
       try subject.startLivePedometerData { pedometerData, error in
          
          //THEN
          XCTAssertNil(error)
          XCTAssertNotNil(pedometerData)
          expectation.fulfill()
       }
       
       wait(for: [expectation], timeout: 1)
    }
    
    
    //MARK: - Test RetrieveSixDayHistoricalPedometerData()
    func testRetrieveSixDayHistoricalPedometerData_stepCountingUnavailable_throwsError() async {
       //GIVEN
       mockPedometer.isAvailableForDevice = false
       
       //WHEN THEN
       do {
          _ = try await subject.retrieveSixDayHistoricalPedometerData()
       } catch {
          XCTAssertEqual(error as! PedometerError, PedometerError.stepCountingUnavailable)
       }
    }
    func testRetrieveSixDayHistoricalPedometerData_permissionDenied_throwsError() async {
       //GIVEN
       mockPedometer.permissionIsAuthorizedByUser = false
       
       //WHEN THEN
       do {
          _ = try await subject.retrieveSixDayHistoricalPedometerData()
       } catch {
          XCTAssertEqual(error as! PedometerError, PedometerError.stepCountingPermissionDenied)
       }
    }
    func testRetrieveSixDayHistoricalPedometerData_recieves6DaysOfHistory() async throws {
       //GIVEN
       mockPedometer.queriedPedometerStepCount_stubbed = Fixtures.validPedometerDatum.stepCount
       let historicalData: [PedometerData]
       
       //WHEN
       historicalData = try await subject.retrieveSixDayHistoricalPedometerData()
       
       //THEN
       XCTAssertEqual(historicalData.count, 6)
    }
    func testRetrieveSixDayHistoricalPedometerData_recievesHistoryInChronologicalOrder() async throws {
       //GIVEN
       mockPedometer.queriedPedometerStepCount_stubbed = Fixtures.validPedometerDatum.stepCount
       let historicalData: [PedometerData]
       
       //WHEN
       historicalData = try await subject.retrieveSixDayHistoricalPedometerData()
       
       //THEN
       for index in 0..<historicalData.count {
          let nextIndex = index + 1
          
          if nextIndex < historicalData.count {
             
             XCTAssertGreaterThan(historicalData[nextIndex].date, historicalData[index].date)
          }
       }
    }
}
