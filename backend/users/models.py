from django.contrib.auth.models import AbstractUser
from django.db import models
from django.core.validators import MinLengthValidator, EmailValidator

class User(AbstractUser):
    email = models.EmailField(
        unique=True,
        validators=[EmailValidator()]
    )
    username = models.CharField(
        max_length=150,
        unique=True,
        validators=[MinLengthValidator(6)]
    )
    phone = models.CharField(max_length=11, unique=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    class Meta:
        db_table = 'users'