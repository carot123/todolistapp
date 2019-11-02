class TodoModel {
    String name;
    String description;
    String time;
    int status;

    TodoModel(this.name, this.description, this.time);

    TodoModel.pos(int status, TodoModel todoModel):
        this.status  = status,
        this.name = todoModel.name,
        this.description = todoModel.description,
        this.time = todoModel.time;

}