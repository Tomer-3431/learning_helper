/// Casts [object] to [T], throwing a [TypeError] if the cast fails.
///
/// Use this when you are certain of the runtime type and want an explicit
/// error on mismatch rather than a silent `null`.
T cast<T extends Object>(dynamic object) => object as T;

/// Attempts to cast [object] to [T], returning `null` instead of throwing
/// if [object] is not an instance of [T].
///
/// Prefer this when reading values from Firebase snapshots whose type is
/// not guaranteed at compile time.
T? tryCast<T extends Object>(dynamic object) => object is T ? object : null;