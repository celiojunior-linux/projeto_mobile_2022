# Generated by Django 4.1.1 on 2022-10-03 01:06

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("task_center", "0001_initial"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="task",
            name="due_date",
        ),
    ]