part of 'search_bloc.dart';

class SearchEvent {}

class LoadSearchEvent extends SearchEvent {
  LoadSearchEvent(this.name);

  final String name;
}
