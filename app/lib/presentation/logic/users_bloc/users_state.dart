part of 'users_bloc.dart';

enum UsersStatus {
  initial,
  loading,
  success,
  editSuccess,
  blockSuccess,
  unBlockSuccess,
  getAllFriendsSuccess,
  error,
}

class UsersState {
  final UsersStatus status;
  final List<User> users;
  final String error;
  final List<User> friends;

  UsersState({
    this.status = UsersStatus.initial,
    this.users = const [],
    this.error = '',
    this.friends = const []
  });

  UsersState copyWith({
    UsersStatus? status,
    List<User>? users,
    String? error,
    List<User>? friends,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      error: error ?? this.error,
      friends: friends ?? this.friends
    );
  }
}

enum ImageUploadState {
  initial,
  loading,
  success,
  error,
}
