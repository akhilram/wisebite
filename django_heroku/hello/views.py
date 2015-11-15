from django.shortcuts import render
from django.http import HttpResponse
import getItems as GI
import os

from .models import Greeting

# Create your views here.
def index(request):

    food_dict = {'peanut':True, 'butter':True, 'peanut butter':True, 'peanut butter jelly':True, 'butter jelly':True, 'jelly mixed':True, 'mixed':True}
    out  = GI.mains(request.GET.get("key",""))#'peanut butter jelly mixed'
    return HttpResponse(out)
    #return render(request, 'index.html')


def db(request):

    greeting = Greeting()
    greeting.save()

    greetings = Greeting.objects.all()

    return render(request, 'db.html', {'greetings': greetings})
