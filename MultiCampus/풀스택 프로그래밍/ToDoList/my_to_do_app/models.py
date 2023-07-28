from django.db import models

# Create your models here.
# ToDoList > my_to_do_app > models.py

class Todo(models.Model):
    content = models.CharField(max_length=255)

