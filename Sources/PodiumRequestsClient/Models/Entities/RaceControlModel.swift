//
//  RaceControlModel.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 7/3/25.
//

import Foundation

/// Represents the type of race control message received during a session.
///
/// This enumeration categorizes race control updates into distinct types that
/// can be used to filter, display, or process messages in the UI or logic layers.
///
/// Backed by `String` raw values for interoperability with external data sources or APIs.
/// The custom initializer normalizes incoming raw strings to one of the supported categories,
/// defaulting to `.other` when the value does not match a known case.
public enum RaceControlCategory: String {
  /// Indicates a message related to DRS (Drag Reduction System), such as activation or deactivation notifications.
  case drs = "Drs"

  /// Indicates a message related to flag status, such as yellow, red, or green flags.
  case flag = "Flag"

  /// A catch-all category for messages that do not fit into known types.
  case other = "Other"

  /// - Use `RaceControlCategory(rawValue:)` to safely map external string input to a category.
  /// - Default behavior ensures resilience against unknown or unexpected input values.
  public init(rawValue: String) {
    switch rawValue {
    case RaceControlCategory.drs.rawValue:
      self = .drs
    case RaceControlCategory.flag.rawValue:
      self = .flag
    default:
      self = .other
    }
  }
}

/// Represents the specific flag states communicated by race control during a session.
///
/// Use this enumeration to interpret and display track status updates,
/// react to safety conditions, and provide appropriate UI indicators.
///
/// - Note:
///   - These flags are typically associated with session state changes, sector-specific warnings, or global conditions.
///   - Pair with `RaceControlCategory.flag` to categorize messages and with optional sector/lap
///   information to provide context in the UI or logs.
public enum RaceControlFlag: String {
  /// A single yellow flag indicates a hazard on the track. Drivers must reduce speed,
  /// avoid overtaking, and be prepared for obstacles or marshals on or near the racing line.
  case yellow = "YELLOW"

  /// Two yellow flags indicate a serious hazard. Drivers must significantly reduce speed,
  /// be prepared to stop, and overtaking is strictly prohibited. Often used for incidents
  /// with vehicles or debris on track.
  case doubleYellow = "DOUBLE YELLOW"

  /// A red flag indicates that the session is suspended or stopped due to unsafe conditions.
  /// All drivers must reduce speed and proceed to the pit lane as directed by race control.
  case red = "RED"

  /// A green flag indicates normal racing conditions. The track is clear and full speed is permitted.
  case green = "GREEN"
}

/// A value type that models a single Race Control message emitted during a session.
///
/// Use `RaceControlModel` to represent, display, and persist race control updates such as
/// flag changes, DRS notifications, sector incidents, and general race messages. The model
/// conforms to `Identifiable`.
public struct RaceControlModel: Identifiable {
  // MARK: Properties
  /// A unique identifier as a string, based on the date.
  public var id: String {
    DateHelper.toIdentifier(date: date)
  }

  /// Classifies the message (e.g., `.flag`, `.drs`, `.other`) for filtering and UI styling.
  public let category: RaceControlCategory

  /// Corresponds to when the message was issued, used to derive a unique identifier.
  public let date: Date

  /// Provides the specific flag state (e.g., `.yellow`, `.red`) when applicable.
  public let flag: RaceControlFlag?

  /// Indicates where on track the message applies.
  public let sector: Int?

  /// Indicates at which lap the message applies.
  public let lap: Int?

  /// The race control message.
  public let message: String

  // MARK: Lifecycle
  /// Initialize a new instance with all the properties.
  public init(
    category: RaceControlCategory,
    date: Date,
    flag: RaceControlFlag?,
    sector: Int?,
    lap: Int?,
    message: String
  ) {
    self.category = category
    self.date = date
    self.flag = flag
    self.sector = sector
    self.lap = lap
    self.message = message
  }
}
