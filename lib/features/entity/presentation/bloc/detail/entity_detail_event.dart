sealed class EntityDetailEvent {
  const EntityDetailEvent();
}

final class EntityDetailOpened extends EntityDetailEvent {
  const EntityDetailOpened(this.id);

  final String id;
}
