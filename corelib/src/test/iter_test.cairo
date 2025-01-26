use core::iter::PeekableTrait;

#[test]
fn test_iter_count() {
    let mut empty_iter = ArrayTrait::<usize>::new().into_iter();
    let count = empty_iter.count();
    assert_eq!(count, 0);

    let mut iter = array![1, 2, 3].into_iter();
    let count = iter.count();

    assert_eq!(count, 3);
}

#[test]
fn test_advance_by() {
    let mut iter = array![1_u8, 2, 3, 4].into_iter();

    assert_eq!(iter.advance_by(2), Ok(()));
    assert_eq!(iter.next(), Some(3));
    assert_eq!(iter.advance_by(0), Ok(()));
    assert_eq!(iter.advance_by(100), Err(99));
}

#[test]
fn test_iter_adapter_map() {
    let mut iter = array![1, 2, 3].into_iter().map(|x| 2 * x);

    assert_eq!(iter.next(), Some(2));
    assert_eq!(iter.next(), Some(4));
    assert_eq!(iter.next(), Some(6));
    assert_eq!(iter.next(), None);
}

#[test]
fn test_iterator_enumerate() {
    let mut iter = array!['a', 'b', 'c'].into_iter().enumerate();

    assert_eq!(iter.next(), Some((0, 'a')));
    assert_eq!(iter.next(), Some((1, 'b')));
    assert_eq!(iter.next(), Some((2, 'c')));
    assert_eq!(iter.next(), None);
}

#[test]
fn test_iterator_zip() {
    let mut iter = array![1, 2, 3].into_iter().zip(array![4, 5, 6]);

    assert_eq!(iter.next(), Some((1, 4)));
    assert_eq!(iter.next(), Some((2, 5)));
    assert_eq!(iter.next(), Some((3, 6)));
    assert_eq!(iter.next(), None);

    // Nested zips
    let mut iter = array![1, 2, 3].into_iter().zip(array![4, 5, 6]).zip(array![7, 8, 9]);

    assert_eq!(iter.next(), Some(((1, 4), 7)));
    assert_eq!(iter.next(), Some(((2, 5), 8)));
    assert_eq!(iter.next(), Some(((3, 6), 9)));
    assert_eq!(iter.next(), None);
}

#[test]
fn test_iter_adapter_fold() {
    let mut iter = array![1, 2, 3].into_iter();
    let sum = iter.fold(0, |acc, x| acc + x);

    assert_eq!(sum, 6);
}

#[test]
fn test_iter_adapter_collect() {
    assert_eq!((0..3_u32).into_iter().collect(), array![0, 1, 2]);
}

#[test]
fn test_iter_adapter_peekable() {
    let mut iter = (1..4_u8).into_iter().peekable();

    // peek() lets us see one step into the future
    assert_eq!(iter.peek(), Option::Some(1));
    assert_eq!(iter.next(), Option::Some(1));
    assert_eq!(iter.next(), Option::Some(2));

    // The iterator does not advance even if we `peek` multiple times
    assert_eq!(iter.peek(), Option::Some(3));
    assert_eq!(iter.peek(), Option::Some(3));
    assert_eq!(iter.next(), Option::Some(3));

    // After the iterator is finished, so is `peek()`
    assert_eq!(iter.peek(), Option::None);
    assert_eq!(iter.next(), Option::None);
}
