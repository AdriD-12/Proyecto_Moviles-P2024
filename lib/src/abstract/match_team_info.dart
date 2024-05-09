class MatchTeamInfo {
  final String id;
  final String score_local;
  final String score_visitor;
  final String goals_local;
  final String goals_visitor;
  final String end_date;
  final String fk_local;
  final String fk_visitor;

  MatchTeamInfo({
    required this.id,
    required this.score_local,
    required this.score_visitor,
    required this.goals_local,
    required this.goals_visitor,
    required this.end_date,
    required this.fk_local,
    required this.fk_visitor,
  });
}
