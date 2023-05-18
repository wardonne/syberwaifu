enum DatabaseWhereOperator {
  eq('='),
  neq('!='),
  gt('>'),
  gte('>='),
  lt('<'),
  lte('<='),
  like('LIKE'),
  notLike('NOT LIKE');

  final String symbal;
  const DatabaseWhereOperator(this.symbal);
}
