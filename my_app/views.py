from django.http import HttpResponse
from .models import CustomUser

# Create your views here.


def index(request):
    response = 'random text'
    user = CustomUser.objects.filter(first_name='Volodymyr')
    if user:
        response = user.first().first_name
    return HttpResponse(response)
