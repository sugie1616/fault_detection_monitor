class Task {
	int x,y;
	String type,name,state;

	String getSourceCode(){
		InputStream ins = new InputStream("../resource/src/" + name + ".k");
		String str,src;
		while ((str = ins.readline()) != null){
			src = src + str + "\n";
		}
		return src;
	}
}

class TaskList {
	Task[] taskList = [];

	void add(Task task){
		taskList.add(task);
		print "added task = " + task;
	}

	Task find(String taskname){
		int i = 0;
		while (taskList[i] != null){
			if (taskList[i].name == taskname){
				return taskList[i];
				break;
			}
			i++;
		}
	}
}

int main(){
	Task task = new Task();
	TaskList taskList = new TaskList();
	task.x = 1;
	task.y = 1;
	task.type = "Event";
	task.name = "test";

	taskList.add(task);
	print "this task's source code = " + task.getSourceCode();
	print "found task = " + taskList.find("test");
}
