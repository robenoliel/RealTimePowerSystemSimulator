'''
OBSERVAÇÕES E PONTOS DE INTERESSE:
    - Checar "save" (~910)
    - Criação da matreiz Am (~1624)
'''

from tkinter import *
from tkinter import messagebox
from tkinter import filedialog
import tkinter.ttk #line separator
import pickle
import numpy as np
from numpy.linalg import inv
import math
import matplotlib
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk
from matplotlib.figure import Figure
import time as timewait
import copy

app= Tk()
#o app eh a janela
app.title('LEMT CIRCUIT SIMULATOR')
#tamanho da janela (app), e aonde voce quer que ela fique na tela:

app.geometry('1300x650+10+10')
app.configure(bg='white')


class Splash(Toplevel): #Loading Screen
    def __init__(self, parent):#init(self,window that it will be topleveled)
        global canvasTop
        
        Toplevel.__init__(self, parent)#creates a toplevel window
        self.title("LOADING")#title of the splash screen
        self.ld = Label(self, text='Loading Graphic User Interface Components')#text will be displayed on screen
        self.ld2 = Label(self, text='PLEASE WAIT!')
        
        w = self.winfo_reqwidth()
        h = self.winfo_reqheight()
        ws = self.winfo_screenwidth()
        hs = self.winfo_screenheight()
        x = (ws/2) - (w/2)
        y = (hs/2) - (h/2)
        self.geometry('+%d+%d' % (x, y)) ## this part allows you to only change the location
        
        #self.loading=PhotoImage(file='lemt_loading.png')#Image of the loading screen
        canvasTop = Canvas(self,width= 400, height= 200)
        
        #canvasTop.create_image(1,1,image=self.loading)
        
        canvasTop.create_text(200,70,fill="darkblue",font="Helvetica 20 italic bold",
                        text="LEMT")
        canvasTop.create_text(200,100,fill="Black",font="Helvetica 20 italic bold",
                        text="Circuit Simulator")
        
    
        self.ld.pack(padx=5,pady=5)
        canvasTop.pack()
        self.ld2.pack(padx=5,pady=5)
        
        lemt_icon=PhotoImage(file='LEMT_lightning.png')

        self.tk.call('wm', 'iconphoto', self._w, lemt_icon )
        ## required to make window show before the program gets to the mainloop
        self.update()
        

app.withdraw() #Hides the main app screen for loading time
splash = Splash(app) #creates the loading screen


pad=3 
app.geometry("{0}x{1}+0+0".format(app.winfo_screenwidth()-pad, app.winfo_screenheight()-pad)) #creates the fullscreen size window


dashBG= 'White'#color of the dashboard(frames in sides)
frameUp = Frame(app, bg = dashBG) #creates frames that will be used to create de dashboards
frameLeft = Frame(app, bg = dashBG)
frameDown = Frame(app, bg = dashBG)
frameRight = Frame(app, bg= dashBG)



frameUp.grid(row=0, column=1, padx=5, pady=5)#grid package was used to improve the layout




btwLabel = Label(frameUp,bg=dashBG,width=5) #Label to make space between the time step and others
btwLabel.grid(column=2, row=0, padx=5,pady=5)

#Vamos criar um frame invisivel para que ao clicarmos em qualquer
#lugar da tela ele ira fazer algo


w=1100
h=550
canvas=Canvas(app,width= w, height= h, cursor = "left_ptr")
canvas.grid(row=1, column=1, padx=5, pady=5)
canvas.configure(background='white')

frameLeft.grid(row=1, column=0, padx=5, pady=5)
frameDown.grid(row=2, column=1, padx=5, pady=5, sticky="nswe")
frameRight.grid(row=1, column=2, padx=5, pady=5, sticky="nswe")

label=Label(frameDown, text='Drag element out of the canvas to delete it',fg='black',font='Arial 10 normal',bg='white')
label.pack(side=BOTTOM,padx=5,pady=5)

hbar = Scrollbar(frameDown, orient=HORIZONTAL)
hbar.config(command=canvas.xview)
hbar.pack(side=TOP, fill=X)

vbar = Scrollbar(frameRight, orient=VERTICAL)
vbar.config(command=canvas.yview)


vbar.pack(side=LEFT, fill=Y, padx=5)

a=1550
b=950
canvas.config(xscrollcommand=hbar.set)
canvas.config(yscrollcommand=vbar.set)

canvas.config(scrollregion=(0,0,a,b))

lemt_icon=PhotoImage(file='LEMT_lightning.png')

app.tk.call('wm', 'iconphoto', app._w, lemt_icon )




#criando as linhas

#dots
reddot=PhotoImage(file='lemt_reddot.png')
greendot=PhotoImage(file='lemt_greendot.png')

blackdot=PhotoImage(file='lemt_blackdot.png')

grid=PhotoImage(file='grid.png')
canvas.create_image(775,485,image=grid)

## finished loading so destroy splash
splash.destroy()

## show window again
app.deiconify()
        
        

wires=[]

def aredondar(x):
    if x%10>5:
        
        return (x//10+1)*10
    else:
        return (x//10)*10

#ELEMENTS LIST WILL RECEIVE ALL ELEMENTS ADDED TO THE CANVAS:
elements=[]
elements_name=[]
elements_id=[]
wires_id=[]
dots=[]

def dot_in_wire(dot,wire):
     x1=dot[0]
     y1=dot[1]
     if min(canvas.coords(wire)[0],canvas.coords(wire)[2]) < x1 < max(canvas.coords(wire)[0],canvas.coords(wire)[2]) and y1==canvas.coords(wire)[1]: #fio na horizontal cruzando o ponto
         return True
     elif min(canvas.coords(wire)[1],canvas.coords(wire)[3]) < y1 <max(canvas.coords(wire)[1],canvas.coords(wire)[3]) and x1==canvas.coords(wire)[0] : #fio na verticalcruzando o ponto
         return True
     else:
         return False

def remove_unnecessary_wires(): #
    for w in wires_id:
        otherwires=wires_id[:]
        otherwires.remove(w)
        for w2 in otherwires:
            if  canvas.coords(w)[1] == canvas.coords(w)[3] and canvas.coords(w2)[1] == canvas.coords(w2)[3]: #Horizontal wire
                if canvas.coords(w2)[0:2]  in [ canvas.coords(w)[0:2],canvas.coords(w)[2:4] ] or canvas.coords(w2)[2:4]  in [ canvas.coords(w)[0:2],canvas.coords(w)[2:4] ]: #WIres touch at some coordinate
                        i=0 
                        for e in elements: 
                            if tuple(canvas.coords(w2)[0:2]) in [ e.start,e.end ] or tuple(canvas.coords(w2)[2:4]) in [ e.start,e.end ]: #if there is no element connected, creates a new wire bigger than both of them 
                                i+=1
                        
                        if i==0:
                            newx1=min(canvas.coords(w)[0],canvas.coords(w)[2],canvas.coords(w2)[2],canvas.coords(w2)[0])
                            newx2=max(canvas.coords(w)[0],canvas.coords(w)[2],canvas.coords(w2)[2],canvas.coords(w2)[0])
                            wnew=canvas.create_line(newx1,canvas.coords(w)[1],newx2,canvas.coords(w)[1],width=1.5)
                            wires_id.append(wnew)
                            
                            canvas.delete(w)
                            canvas.delete(w2)
                            wires_id.remove(w)
                            wires_id.remove(w2)
                            break
                                    
            if  canvas.coords(w)[0] == canvas.coords(w)[2] and canvas.coords(w2)[2] == canvas.coords(w2)[0]: #Vertical wire
                if canvas.coords(w2)[0:2]  in [ canvas.coords(w)[0:2],canvas.coords(w)[2:4] ] or canvas.coords(w2)[2:4]  in [ canvas.coords(w)[0:2],canvas.coords(w)[2:4] ]: #WIres touch at some coordinate
                        i=0 
                        for e in elements: 
                            if tuple(canvas.coords(w2)[0:2]) in [ e.start,e.end ] or tuple(canvas.coords(w2)[2:4]) in [ e.start,e.end ]: #if there is no element connected, creates a new wire bigger than both of them 
                                i+=1
                        if i==0:
                            
                            newy1=min(canvas.coords(w)[1],canvas.coords(w)[3],canvas.coords(w2)[1],canvas.coords(w2)[3])
                            newy2=max(canvas.coords(w)[1],canvas.coords(w)[3],canvas.coords(w2)[1],canvas.coords(w2)[3])
                           
                            wnew=canvas.create_line(canvas.coords(w)[0],newy1,canvas.coords(w)[2],newy2,width=1.5)
                            wires_id.append(wnew)
                            
                            canvas.delete(w)
                            canvas.delete(w2)
                            wires_id.remove(w)
                            wires_id.remove(w2)
                            break
            
    for w in wires_id: #This loop makes the program cut a wire in half if there is a "T wire form".
        otherwires=wires_id[:]
        otherwires.remove(w)
        for w2 in otherwires:
            if dot_in_wire(canvas.coords(w)[:2],w2):
                
                wnew=canvas.create_line(canvas.coords(w)[0],canvas.coords(w)[1],canvas.coords(w2)[0],canvas.coords(w2)[1],width=1.5)
                wnew2=canvas.create_line(canvas.coords(w)[0],canvas.coords(w)[1],canvas.coords(w2)[2],canvas.coords(w2)[3],width=1.5)
                canvas.delete(w2)
                wires_id.remove(w2)
                wires_id.append(wnew)
                wires_id.append(wnew2)
                
            elif dot_in_wire(canvas.coords(w)[2:4],w2):

                wnew=canvas.create_line(canvas.coords(w)[2],canvas.coords(w)[3],canvas.coords(w2)[0],canvas.coords(w2)[1],width=1.5)
                wnew2=canvas.create_line(canvas.coords(w)[2],canvas.coords(w)[3],canvas.coords(w2)[2],canvas.coords(w2)[3],width=1.5)
                canvas.delete(w2)
                wires_id.remove(w2)
                wires_id.append(wnew)
                wires_id.append(wnew2)
                
def search_dotconnection(element,dot): #This function receives an element and the dot we want to analyse. Here we want to check if am element is connected to the middle of a wire.
   #Splits the wire in two if there are any elements connected to the middle of it
    x1=dot[0]
    y1=dot[1]
    for w in wires_id[:]:
            if dot_in_wire(dot,w) and canvas.coords(w)[1]==canvas.coords(w)[3] and element.angle in [90,270] : #fio na horizontal cruzando o ponto
                
                wnew1=canvas.create_line(canvas.coords(w)[0],canvas.coords(w)[1],x1,y1,width=1.5)
                wnew2=canvas.create_line(canvas.coords(w)[2],canvas.coords(w)[3],x1,y1,width=1.5)
                wires_id.append(wnew1)
                wires_id.append(wnew2)
                canvas.delete(w)
                wires_id.remove(w)
                
            elif  dot_in_wire(dot,w) and canvas.coords(w)[0]==canvas.coords(w)[2] and element.angle in [0,180]: #fio na verticalcruzando o ponto
                
                wnew1=canvas.create_line(canvas.coords(w)[0],canvas.coords(w)[1],x1,y1,width=1.5)
                wnew2=canvas.create_line(canvas.coords(w)[2],canvas.coords(w)[3],x1,y1,width=1.5)
                wires_id.append(wnew1)
                wires_id.append(wnew2)
                canvas.delete(w)
                wires_id.remove(w)





def search_connections(): #Connects the end of objects with the end of wires if they touch and removes the dots that are in a connection
    for e in elements:
        for w in wires_id:
            if e.start in [ tuple(canvas.coords(w)[0:2]), tuple(canvas.coords(w)[2:4]) ]: #if the one end of elements coincide with the end of a wire and there is no connection there, a connection is added
                i=0
                for d in dots:
                    if tuple(canvas.coords(d))==e.start:
                        i+=1
                if i == 0: #There are no dots in the coordinate analysed (e.start)
                    dot=canvas.create_image(e.start[0],e.start[1],image=blackdot)
                    dots.append(dot)
            
            if e.end in [ tuple(canvas.coords(w)[0:2]), tuple(canvas.coords(w)[2:4]) ]: #if the one end of elements coincide with the end of a wire and there is no connection there, a connection is added
                i=0
                for d in dots:
                    if tuple(canvas.coords(d))==e.end:
                        i+=1
                if i == 0: #There are no dots in the coordinate analysed (e.end)
                    dot=canvas.create_image(e.end[0],e.end[1],image=blackdot)
                    dots.append(dot)
    for  d in dots[:]:
        i=0
        c=0
        for e in elements:
            if tuple(canvas.coords(d)) in [e.start,e.end]:
                i+=1 #indicates that there is an element connected here
        for w in wires_id:
            if canvas.coords(d) in [ canvas.coords(w)[0:2], canvas.coords(w)[2:4] ]:
                c+=1 #indicates that there is a wire connected here
        
        if i==0 or c==0: #if there are no wires or no elements that touch that dot, it is removed
            canvas.delete(d)
            dots.remove(d)


        
#____________________WIRES CLASS___________________________________________________________

class Wire():
    def __init__(self):
        
        ConductorLabel = Label(frameLeft, text='Conductors',bg='White')
        ConductorLabel.pack(side=TOP, padx=5,pady=5)
        
        self.n=0
        self.b=Button(frameLeft,text='Wire',bg='yellow')
        self.b.pack(side=TOP, padx=5,pady=5)
        self.b.bind('<ButtonPress-1>',self.bcommand)
        
        
    def bcommand(self,event):
        global label
        
        if eraser_instance.n==0:
            if self.n==0:
                self.n=1
                self.b.configure(text='Wire in use',bg='red')
                label['text']='*Wire in use*'
                label['fg']='darkred'        
                canvas.bind('<ButtonPress-1>',self.press)
                canvas.bind('<ButtonPress-3>',self.press_right)
                canvas.config(cursor='top_left_arrow')
            else:
                self.n=0
                self.b.configure(text='Wire',bg='yellow')
                label['text']=''
                label['fg']='black'
                canvas.unbind('<ButtonPress-1>')
                canvas.unbind('<ButtonPress-3>')
                canvas.config(cursor='arrow')
        else:
            label['text']='*Cant use wire and eraser at the same time*'
    
    def press_right(self,event):
        if self.n==1 and eraser_instance.n==0:
            label['text']='*Wire in use*'
            label['fg']='darkred'
            canvas.bind('<B3-Motion>',self.motion2)
            self.x=canvas.canvasx(event.x)
            self.y=canvas.canvasy(event.y)
            self.dashline=canvas.create_line(self.x,self.y,self.x,self.y)
            self.dashline2=canvas.create_line(self.x,self.y,self.x,self.y)
            self.dashline3=canvas.create_line(self.x,self.y,self.x,self.y)
            self.dashline4=canvas.create_line(self.x,self.y,self.x,self.y)
           
    def motion2(self,event):
        if self.n ==1:
            mousex=aredondar(canvas.canvasx(event.x))
            mousey=aredondar(canvas.canvasy(event.y))
            x=aredondar(self.x)
            y=aredondar(self.y)
            canvas.delete(self.dashline)
            canvas.delete(self.dashline2)
            canvas.delete(self.dashline3)
            canvas.delete(self.dashline4)
            self.dashline=canvas.create_line(x,y,x,mousey,width=0.5,fill='red', dash=(2,8))
            self.dashline2=canvas.create_line(x,mousey,mousex,mousey,width=0.5,fill='red',dash=(2,8))   
            self.dashline3=canvas.create_line(mousex,mousey,mousex,y,width=0.5,fill='red',dash=(2,8))
            self.dashline4=canvas.create_line(mousex,y,x,y,width=0.5,fill='red',dash=(2,8))
        
            canvas.bind('<ButtonRelease-3>',self.release2)
            self.region=[(x,y),(mousex,mousey)]
            
            
    def release2(self,event):
        if self.n==1:
            canvas.delete(self.dashline)
            canvas.delete(self.dashline2)
            canvas.delete(self.dashline3)
            canvas.delete(self.dashline4)
            
            for wire in wires_id[:]:
                self.ymin=min(self.region[0][1],self.region[1][1])
                self.ymax=max(self.region[0][1],self.region[1][1])
                self.xmin=min(self.region[0][0],self.region[1][0])
                self.xmax=max(self.region[0][0],self.region[1][0])
                if len(canvas.coords(wire))!=0:
                    if self.xmin<canvas.coords(wire)[0]<self.xmax and self.ymin<canvas.coords(wire)[1]<self.ymax and self.xmin<canvas.coords(wire)[2]<self.xmax and self.ymin<canvas.coords(wire)[3]<self.ymax:
                        print('wire: ', canvas.coords(wire))
                        wires_id.remove(wire)
                        canvas.delete(wire) #REMOVES WIRE FROM LISTS
       
        
    def press(self,event):
        if self.n==1:
            label['text']='*Wire in use*'
            label['fg']='darkred'
            
            self.x=canvas.canvasx(event.x)
            self.y=canvas.canvasy(event.y)
            self.line=canvas.create_line(self.x,self.y,self.x,self.y)
            self.line2=canvas.create_line(self.x,self.y,self.x,self.y)
            wires_id.append(self.line)
            wires_id.append(self.line2)
            canvas.bind('<B1-Motion>',self.motion1)
            canvas.bind('<ButtonRelease-1>',self.release)
    
    def motion1(self,event):
        if self.n ==1:
            mousex=aredondar(canvas.canvasx(event.x))
            mousey=aredondar(canvas.canvasy(event.y))
            x=aredondar(self.x)
            y=aredondar(self.y)
            
            if self.line in wires_id:
                wires_id.remove(self.line)
                canvas.delete(self.line)
            
            if self.line2 in wires_id:
                wires_id.remove(self.line2)
                canvas.delete(self.line2)
            
            if (x,y)!=(x,mousey):
                self.line=canvas.create_line(x,y,x,mousey,width=1.5)
                wires_id.append(self.line)
            if (x,mousey)!= (mousex,mousey):
                self.line2=canvas.create_line(x,mousey,mousex,mousey,width=1.5)
                wires_id.append(self.line2)
          
            #TEM QUE RESOLVER O PROBLEMA DE TER UM FIO DE COMPRIMENTO 0!!
            
            search_connections()
            
    def release(self,event):

        if self.n ==1: # Wire is active
            canvas.unbind('<B1-Motion>')
            canvas.unbind('<ButtonRelease-1>')
           
            if canvas.coords(self.line2)[0:2] != canvas.coords(self.line2)[2:4] and len(canvas.coords(self.line2)) == 4 and self.line2 not in wires_id:
                wires_id.append(self.line2)
                 
            if canvas.coords(self.line)[0:2] != canvas.coords(self.line)[2:4] and len(canvas.coords(self.line)) == 4 and self.line not in wires_id:
                wires_id.append(self.line)
                
            print('wires:',wires)
            print('length of wires_id:',len(wires_id))
        
            for w in wires_id:
                print(tuple(canvas.coords(w)))
            
            for e in elements:
                search_dotconnection(e,e.start)
                search_dotconnection(e,e.end)
            
            remove_unnecessary_wires()
            search_connections()
            
      
            
            removals=[]
            wires_id2= wires_id[:]
            for wire in wires_id[:]:
                coords=tuple(canvas.coords(wire))

                if coords[3]==coords[1]: #Horizontal wire
                    wires_id_rest=wires_id[:]
                    wires_id_rest.remove(wire)
                    for i in wires_id_rest:
                        coords2=tuple(canvas.coords(i))
                        
                        if min(coords2[1],coords2[3])<coords[1]<max(coords2[1],coords2[3]) and min(coords[0],coords[2]) < coords2[0] < max(coords[0],coords[2]):
                            
                            label['text']= 'Rodei'
                            wires_id.remove(wire)
                            wires_id.remove(i)
                            canvas.delete(i)
                            canvas.delete(wire)
                            w1=canvas.create_line(coords2[0],coords[1],coords[0],coords[1],width=1.5)
                            w2=canvas.create_line(coords2[0],coords[1],coords[2],coords[3],width=1.5)
                            w3=canvas.create_line(coords2[0],coords[1],coords2[0],coords2[1],width=1.5)
                            w4=canvas.create_line(coords2[0],coords[1],coords2[2],coords2[3],width=1.5)
                            wires_id.append(w1)
                            wires_id.append(w2)
                            wires_id.append(w3)
                            wires_id.append(w4)
                            

wire_instance=Wire()


class electricComponent(): 
    
    def __init__(self,Value,file,name,letter,size,x=100,y=100,orientacao=0,unit=None):
        global elements
        global elements_name
        print('Class CREATED')
        self.letter=letter
        elements.append(self)
        elements_name.append(type(self).__name__)
        print(elements_name)
        self.name='{}{}'.format(self.letter,elements_name.count(type(self).__name__))
        self.angle=orientacao
        self.file=file
        self.size=size
        self.value=Value
        self.unit=unit

        #Ao inicializar precisamos pegar p angulo de orientacao dele, p criar a imagem correspondente:
        
        if self.angle==0:
            self.image=PhotoImage(file=str(self.file+'0'+'.png'))
            self.object=canvas.create_image(x,y,image=self.image)
            self.coordinates=canvas.coords(self.object)
            self.text=canvas.create_text(self.coordinates[0],self.coordinates[1]-25,fill="black", text=self.name)
            self.start=(self.coordinates[0]+self.size,self.coordinates[1]) 
            self.end=(self.coordinates[0]-self.size,self.coordinates[1])
        elif self.angle==90:
            self.image=PhotoImage(file=str(self.file+'90'+'.png'))
            self.object=canvas.create_image(x,y,image=self.image)
            self.coordinates=canvas.coords(self.object)
            self.text=canvas.create_text(self.coordinates[0]+25,self.coordinates[1],fill="black", text=self.name)
            self.start=(self.coordinates[0],self.coordinates[1]-self.size) 
            self.end=(self.coordinates[0],self.coordinates[1]+self.size)
        elif self.angle==180:
            self.image=PhotoImage(file=str(self.file+'180'+'.png'))
            self.object=canvas.create_image(x,y,image=self.image)
            self.coordinates=canvas.coords(self.object)
            self.text=canvas.create_text(self.coordinates[0],self.coordinates[1] -25,fill="black", text=self.name)
            self.start=(self.coordinates[0]-self.size,self.coordinates[1]) 
            self.end=(self.coordinates[0]+self.size,self.coordinates[1])

        elif self.angle==270:
            self.image=PhotoImage(file=str(self.file+'270'+'.png'))
            self.object=canvas.create_image(x,y,image=self.image)
            self.coordinates=canvas.coords(self.object)
            self.text=canvas.create_text(self.coordinates[0]+25,self.coordinates[1],fill="black", text=self.name)
            self.start=(self.coordinates[0],self.coordinates[1]+self.size) 
            self.end=(self.coordinates[0],self.coordinates[1]-self.size) 
        
        canvas.tag_bind(self.object,'<ButtonRelease-1>',self.release)
        canvas.tag_bind(self.object,'<ButtonPress-1>',self.press)
        canvas.tag_bind(self.object,'<ButtonPress-3>',self.rotate)
        

    def rotate(self,event):  #Rotacao do elemento no canvas
       
        for dot in dots[:]:
            if tuple(canvas.coords(dot)) in [self.start,self.end]:
                canvas.delete(dot)
                dots.remove(dot)
        
        if self.angle==0:
            self.image=PhotoImage(file=str(self.file+'90'+'.png'))
            self.angle=90
            canvas.delete(self.text)
            self.text=canvas.create_text(self.coordinates[0]+25,self.coordinates[1],fill="black", text=self.name)
            self.start=(self.coordinates[0],self.coordinates[1]-self.size) 
            self.end=(self.coordinates[0],self.coordinates[1]+self.size)
        elif self.angle==90:
            self.image=PhotoImage(file=self.file+'180'+'.png')
            self.angle=180
            canvas.delete(self.text)
            self.text=canvas.create_text(self.coordinates[0],self.coordinates[1]-25,fill="black", text=self.name)
            self.start=(self.coordinates[0]-self.size,self.coordinates[1]) 
            self.end=(self.coordinates[0]+self.size,self.coordinates[1])
            
        elif self.angle==180:
            self.image=PhotoImage(file=self.file+'270'+'.png')
            self.angle=270
            canvas.delete(self.text)
            self.text=canvas.create_text(self.coordinates[0]+25,self.coordinates[1],fill="black", text=self.name)
            self.start=(self.coordinates[0],self.coordinates[1]+self.size) 
            self.end=(self.coordinates[0],self.coordinates[1]-self.size)
            
        else:
            self.image=PhotoImage(file=self.file+'0'+'.png')
            self.angle=0
            canvas.delete(self.text)
            self.text=canvas.create_text(self.coordinates[0],self.coordinates[1]-25,fill="black", text=self.name)
            self.start=(self.coordinates[0]+self.size,self.coordinates[1]) 
            self.end=(self.coordinates[0]-self.size,self.coordinates[1])  

        #Como mudamos a imagem temos que dar bind novamente:
        self.object=canvas.create_image(self.coordinates[0],self.coordinates[1],image=self.image)
        canvas.tag_bind(self.object,'<ButtonRelease-1>',self.release)
        canvas.tag_bind(self.object,'<ButtonPress-1>',self.press)
        canvas.tag_bind(self.object,'<ButtonPress-3>',self.rotate)

        if isinstance(self,Ground): #Se o componente for terra, ele possui apenas o terminal de entrada
            self.end=self.start #Nesse caso, terminal de entrada igual ao de saida
        
        search_dotconnection(self,self.start)
        search_dotconnection(self,self.end)
        remove_unnecessary_wires()
        search_connections()
        
    def motion1(self,event):
        global elements
        if self in elements:
            x=canvas.coords(self.object)[0]
            y=canvas.coords(self.object)[1]
            mousex=canvas.canvasx(event.x)
            mousey=canvas.canvasy(event.y)
            canvas.move(self.object,aredondar(mousex-x),aredondar(mousey-y)) #mexe o objeto pelo vetor 
            self.coordinates=canvas.coords(self.object)
            
            if  self.angle==0:
                self.start=(self.coordinates[0]+self.size,self.coordinates[1]) 
                self.end=(self.coordinates[0]-self.size,self.coordinates[1])
                canvas.delete(self.text)
                self.text=canvas.create_text(self.coordinates[0],self.coordinates[1]-25,fill="black", text=self.name)
                
            elif  self.angle==90:
                self.start=(self.coordinates[0],self.coordinates[1]-self.size) 
                self.end=(self.coordinates[0],self.coordinates[1]+self.size)
                canvas.delete(self.text)
                self.text=canvas.create_text(self.coordinates[0]+25,self.coordinates[1],fill="black", text=self.name)
                
            elif self.angle==180:
                self.start=(self.coordinates[0]-self.size,self.coordinates[1]) 
                self.end=(self.coordinates[0]+self.size,self.coordinates[1])
                canvas.delete(self.text)
                self.text=canvas.create_text(self.coordinates[0],self.coordinates[1]-25,fill="black", text=self.name)
               
            else:
                self.start=(self.coordinates[0],self.coordinates[1]+self.size) 
                self.end=(self.coordinates[0],self.coordinates[1]-self.size)
                canvas.delete(self.text)
                self.text=canvas.create_text(self.coordinates[0]+25,self.coordinates[1],fill="black", text=self.name)
            #self.dot1 e self.dot2 sao os pontos que indicam conexoes, quando sao criados sao colocados na lista dots, que contem todos os pontos criados no canvas
            
            if isinstance(self,Ground) or isinstance(self,Voltmeter): #Se o componente for terra, ele possui apenas o terminal de entrada
                self.end=self.start #Nesse caso, terminal de entrada igual ao de saida
            
            search_dotconnection(self,self.start)
            search_dotconnection(self,self.end)
            remove_unnecessary_wires()
            search_connections()
            
            
    def press(self,event):
        print('Fala ae',canvas.bbox(self.object))
        if wire_instance.n==0 and eraser_instance.n==0: #The element cant be moved if the wire or the eraser are in use.
            app.bind('<B1-Motion>',self.motion1)
            label['text']='{}: {}{}'.format(self.name,self.value,self.unit)
           
        
            print('A',len(wires_id))
            for w in wires_id:
                print(canvas.coords(w))
            
            print('A')
    def release(self,event):# Ao soltar o botao queremos que o movimento do mouse na tela seja desassociado ao movimento do objeto clicado:
        global elements
        
        if self.coordinates[0] in range (0,2000) and self.coordinates[1] in range (0,2000):
            app.unbind('<B1-Motion>') 
        else:
            elements_name.remove(type(self).__name__)
            canvas.delete(self.object)
            elements.remove(self)
            app.unbind('<B1-Motion>') 
            
    def delete(self): #Funcao para deletar os elementos da tela:
        elements_name.remove(type(self).__name__)
        canvas.delete(self.object)
        canvas.delete(self.text)
        elements.remove(self)

class Voltmeter(electricComponent):
    def __init__(self,Value=None,x=100,y=100,orientacao=270,unit=None):
        electricComponent.__init__(self,Value,'Voltmeter','Voltmeter','VM',30,x,y,orientacao,unit)
        if self.end != self.start:
            self.end = self.start

class electricComponentAC(electricComponent):
    def __init__(self,value,file,name,letter,size,x=100,y=100,orientacao=0,unit=None,freq=0,freq_unit='Hz',phase=0,phase_unit='degr',offset=0,offset_unit=None):
        electricComponent.__init__(self,value,file,name,letter,50,x,y,orientacao,unit)
        self.freq = freq
        self.freq_unit = freq_unit
        self.phase = phase
        self.phase_unit = phase_unit
        self.offset = offset
        self.offset_unit = offset_unit
        
    def press(self,event):
        if wire_instance.n==0 and eraser_instance.n==0: #The element cant be moved if the wire or the eraser are in use.
            app.bind('<B1-Motion>',self.motion1)
            label['text']='{}: {}{} Frequency: {}{} Phase: {}{} Offset: {}{}'.format(self.name,self.value,self.unit,
                                                                                     self.freq,self.freq_unit,
                                                                                     self.phase,self.phase_unit,
                                                                                     self.offset,self.offset_unit)

class Resistor(electricComponent): #Classe Resistor e filha de componente elétrico
    def __init__(self,Value,x=100,y=100,orientacao=0,unit='Ω'):
        electricComponent.__init__(self,Value,'lemt_resistor','Resistor','R',40,x,y,orientacao,unit) #Resistor eh filha da classe electricComponent,
                                                                                            #    possui tamanho 40, identificacao R, nome Resistor
                                                                                            #    e file 'comp2_resistor'
#O mesmo vale para as outras classes
class Capacitor(electricComponent):
    def __init__(self,Value,x=100,y=100,orientacao=0,unit='F'):
        electricComponent.__init__(self,Value,'lemt_capacitor','Capacitor','C',40,x,y,orientacao,unit)

class Inductor(electricComponent): #Mexer na imagem do indutor (n centralizada)
    def __init__(self,Value,x=100,y=100,orientacao=0,unit='H'):
        electricComponent.__init__(self,Value,'lemt_inductor','Inductor','L',40,x,y,orientacao,unit)

class DCVoltagesource(electricComponent):
    def __init__(self,Value,x=100,y=100,orientacao=0,unit='V'):
        electricComponent.__init__(self,Value,'lemt_voltagesource','Voltagesource','V',50,x,y,orientacao,unit) 

class currentSource(electricComponent):
    def __init__(self,Value,x=100,y=100,orientacao=0,unit='A'):
        electricComponent.__init__(self,Value,'lemt_currentsource','Currentsource','I',50,x,y,orientacao,unit) 


class ACsource(electricComponentAC):
    def __init__(self,Value,freq,phase,offset,x=100,y=100,orientacao=0,unit='V'):
        electricComponentAC.__init__(self,Value,'lemt_ACsource','ACsource','A',50,x,y,orientacao,unit,
                                     freq = freq,phase = phase,offset=offset,offset_unit='V')
        self.frequency=freq
        self.phase=phase
        self.offset=offset
        


class current_ACsource(electricComponentAC):
    def __init__(self,Value,freq,phase,offset,x=100,y=100,orientacao=0,unit='A'):
        electricComponentAC.__init__(self,Value,'lemt_currentACsource','CurrentACsource','B',50,x,y,orientacao,unit,
                                     freq = freq,phase = phase,offset=offset,offset_unit='A')
        self.frequency=freq
        self.phase=phase
        self.offset=offset

class Ground(electricComponent):
    def __init__(self,Value=None,x=100,y=100,orientacao=90,unit=None):
        electricComponent.__init__(self,Value,'lemt_ground','Ground','G',20,x,y,orientacao,unit)
        if self.end != self.start:
            self.end = self.start
            
    def press(self,event): #Overloading the method once this kind of component has no value
        print('Fala ae',canvas.bbox(self.object))
        if wire_instance.n==0 and eraser_instance.n==0: #The element cant be moved if the wire or the eraser are in use.
            app.bind('<B1-Motion>',self.motion1)
            label['text']='{}'.format(self.name)
           
        
            print('A',len(wires_id))
            for w in wires_id:
                print(canvas.coords(w))

            

class Voltmeter(electricComponent):
    def __init__(self,Value=None,x=100,y=100,orientacao=270,unit=None):
        electricComponent.__init__(self,Value,'Voltmeter','Voltmeter','VM',30,x,y,orientacao,unit)
        if self.end != self.start:
            self.end = self.start
           
    def press(self,event):
        print('Fala ae',canvas.bbox(self.object))
        if wire_instance.n==0 and eraser_instance.n==0: #The element cant be moved if the wire or the eraser are in use.
            app.bind('<B1-Motion>',self.motion1)
            label['text']='{}'.format(self.name)
           
        
            print('A',len(wires_id))
            for w in wires_id:
                print(canvas.coords(w))


class Eraser():
    def __init__(self):
        
        self.n=0
        self.b=Button(frameRight,text='Eraser',bg='yellow')
        self.b.pack(side=TOP, padx=10,pady=5)
        self.b.bind('<ButtonPress-1>',self.bcommand)
        
    def bcommand(self,event):
        global label
        
        if wire_instance.n==0:
            if self.n==0:
                self.n=1
                self.b.configure(text='Eraser in use',bg='red')
                label['text']='*Eraser in use*'
                label['fg']='darkred'        
                canvas.bind('<ButtonPress-1>',self.press)
                canvas.config(cursor='dot')
            else:
                self.n=0
                self.b.configure(text='Eraser',bg='yellow')
                label['text']=''
                label['fg']='black'
                canvas.unbind('<ButtonPress-1>')
                canvas.config(cursor='arrow')
        
        else:
            label['text']='*Cant use wire and eraser at the same time*'
    
    def action(self,mousex,mousey): #This function checks if there is a collison between the eraser and any object or wire
                                   #and then deletes it.
            if self.n==1:
                for instance in wires_id[:]:
                    wire=canvas.coords(instance)
                    if wire[0]==wire[2]:
                        if min(wire[1],wire[3]) < mousey < max(wire[1],wire[3]) and mousex==wire[0]:
                            wires_id.remove(instance)
                            canvas.delete(instance) #REMOVES WIRE FROM LISTS
                    if wire[1]==wire[3]:
                        if min(wire[0],wire[2]) < mousex < max(wire[0],wire[2]) and mousey==wire[3]:
                            wires_id.remove(instance) #REMOVES WIRE FROM LISTS
                            canvas.delete(instance)
                
                for element in elements:
                    box=canvas.bbox(element.object)
                    x1=box[0]
                    x2=box[2]
                    y1=box[1]
                    y2=box[3]
                    if min(y1,y2) < mousey < max(y1,y2) and min(x1,x2) < mousex < max(x1,x2):
                        element.delete()
                
                for e in elements:
                    search_dotconnection(e,e.start)
                    search_dotconnection(e,e.end)
            
                remove_unnecessary_wires()
                search_connections()
    
    def press(self,event):
        if self.n==1:
            label['text']='*Eraser in use*'
            label['fg']='darkred'
            canvas.bind('<B1-Motion>',self.motion)
            canvas.config(cursor='dot')
            mousex=canvas.canvasx(event.x)
            mousey=canvas.canvasy(event.y)
            self.action(mousex,mousey)
            
    def motion(self,event):
        if self.n ==1:
            mousex=canvas.canvasx(event.x)
            mousey=canvas.canvasy(event.y)
            self.mouse_coordinates= (mousex,mousey)
            self.action(mousex,mousey)
    
                        
                         
    def release2(self,event):
        print('Released')
              
eraser_instance=Eraser()
                    
                    
###_______________________CREATING CLEAR BUTTON_______________________

res_coords=[]
nos=[]
pontos=[]
wires_2=[]
nodes_images=[]
element_location_start=[]
element_location_end=[]
element_location=[]
nos_id=[]
greendots=[]


def clear():
    global elements
    global greendots
    global nodes_images
    global wires_id
    global dots
    
    for n in wires_id:
        canvas.delete(n)
    wires_id=[]

    label['text']= '*Canvas Cleared*'
    
    elements2=elements[:]
    for element in elements2:
        element.delete()
    for element in greendots:
        canvas.delete(element)
    for element in dots:
        canvas.delete(element)
    for element in nodes_images:
        canvas.delete(element)
    
    greendots=[]
    nodes_images=[]
    nos=[]
    elements=[]
    dots=[]
#___________________________________________
    
clearButton = Button(frameRight, text='Clear',bg='Yellow',command=clear)#clear Button of the ckt
clearButton.pack(side=TOP, padx=10,pady=5)



#Define menu class of the simulator_______________________________________________________________
class menuSystem:
    def __init__(self, master):
        self.menu = Menu(master)
        
        self.menuArq = Menu(self.menu)
        self.menuArq.add_command(label='Open', command=self.Open)
        self.menuArq.add_command(label='Save', command=self.Save)
        self.menuArq.add_command(label='HLS workspace', command=self.defineWorkspace)
        self.menuArq.add_command(label='Quit', command=self.closeWindow)
        self.menu.add_cascade(menu=self.menuArq, label='File')
        
        
        self.menuEdit = Menu(self.menu)
        self.menuEdit.add_command(label='Clear', command=clear)
        self.menu.add_cascade(menu=self.menuEdit, label='Edit')

        
        self.menuHelp = Menu(self.menu)
        self.menuHelp.add_command(label='Program Data', command=self.data)
        self.menuHelp.add_command(label='Guide', command=self.helpGuide)
        self.menu.add_cascade(menu=self.menuHelp, label='Help')

        
        master.config(menu=self.menu)
        
        
    def defineWorkspace(self):
        global HLSworkspace
        try:
            directory = filedialog.askdirectory()
            HLSworkspace='{}'.format(directory)
        except:
            HLSworkspace = ''
            messagebox.showerror('Salvar workspace', 'O workspace HLS não foi salvo')


#Save function____________________
    
    def Save(self):
        try:
            name =  filedialog.asksaveasfilename(initialdir = "/",title = "Select file",filetypes = (("all files","*.txt"),("all files","*.*")))
            print(name)
            path='{}'.format(name)
        
            Dic={}
            for e in elements:
                if e.name[0]=='A' or e.name[0]=='B':
                    Dic[e.name]=(e.value,e.frequency,e.phase,e.offset,e.coordinates[0],e.coordinates[1],e.angle)
                else:
                    Dic[e.name]=(e.value,e.coordinates[0],e.coordinates[1],e.angle) # o dicionario Dic que sera salvo eh da forma {N:v,x,y,A} aonde N eh a letra que indica o tipo do elemento,
                                                                                # v indica o valor dele, x,y a sua posicao no canvas, e A a orientacao (90 ou 0 graus)
                
            Dic['W']=[]
            for wire in wires_id:
                Dic['W'].append(canvas.coords(wire))
        
            Dic['D']=[]
            
            for ponto in dots:
                Dic['D'].append(canvas.coords(ponto))
                
            Dic['timeStep'] = timeStepRequest.get()
            Dic['simulationTime'] = simulationTimeRequest.get()
            Dic['projectName'] = circuitNameRequest.get()
            Dic['precision'] = precision.get()
            Dic['HLSworkspace'] = HLSworkspace
            
            f = open(path,'w+b')
            pickle.dump(Dic,f)
            f.close()
        except:
            messagebox.showerror('Salvar', 'O circuito não foi salvo')
    
    
    def Open(self):
        
        global HLSworkspace
        
        name=filedialog.askopenfilename(initialdir = "/",title = "Select file",filetypes = (("all files","*.txt"),("all files","*.*")))
    
        f=open(str(name),'r+b')
        d=pickle.load(f)
        f.close()
        print(d)
    
        for i in d:
            
            if i in ['timeStep','simulationTime','projectName','precision','HLSworkspace']:
                if i == 'timeStep':
                    timeStepRequest.delete(0, END)
                    timeStepRequest.insert(0, d[i])
                elif i == 'simulationTime':
                    simulationTimeRequest.delete(0, END)
                    simulationTimeRequest.insert(0, d[i])
                elif i == 'projectName':
                    circuitNameRequest.delete(0, END)
                    circuitNameRequest.insert(0, d[i])
                elif i == 'precision':
                    precision.set(d[i])
                elif i == 'HLSworkspace':
                    HLSworkspace = d[i]
                continue
            
            if i[0]=='R': #Se a primeira letra do nome for R (Resistor) o programa cria um resistor 
                e=Resistor(d[i][0],d[i][1],d[i][2],d[i][3])
                
            if i[0]=='C': #Se a primeira letra do nome for C (Capacitor) o programa cria um capacitor 
                e=Capacitor(d[i][0],d[i][1],d[i][2],d[i][3])
    
            if i[0]=='V': #Se a primeira letra do nome for V (fonte de tensao) e programa cria uma fomte de tensao
                e=DCVoltagesource(d[i][0],d[i][1],d[i][2],d[i][3])
    
            if i[0]=='L': #Se a primeira letra do nome for L
                e=Inductor(d[i][0],d[i][1],d[i][2],d[i][3])
            
            if i[0]=='I': #Se a primeira letra do nome for L
                e=currentSource(d[i][0],d[i][1],d[i][2],d[i][3])
                
            if i[0]=='G': #Se a primeira letra do nome for G cria o terra
                e=Ground(d[i][0],d[i][1],d[i][2],d[i][3])
            
            if i[0]=='A': #If the indication letter is A the program creates an alternate voltage source
                e=ACsource(d[i][0],d[i][1],d[i][2],d[i][3],d[i][4],d[i][5],d[i][6])
                
            if i[0]=='B': #If the indication letter is B the program creates an alternate current source
                e=current_ACsource(d[i][0],d[i][1],d[i][2],d[i][3],d[i][4],d[i][5],d[i][6])

            if i[0]=='W': #W indica a lista com os fios
                for fio in d[i]:
                    f=canvas.create_line(fio[0],fio[1],fio[2],fio[3],width=1.5) #criando os fios
                    wires_id.append(f)
                    
            if i=='D': #P indica a lista com os pontos (dots)
                for dot in d[i]:
                    p=canvas.create_image(dot[0],dot[1],image=greendot)
                    dots.append(p)            
        
    
    #define all the functions of menu system       
    def closeWindow(self):
        app.destroy()
    
    #Text with the program data
    def data(self):
        data_app = Tk()
        data_app.title('Program Data')
        lb = Label(data_app, text='This is LEMT CIRCUIT SIMULATOR')
        lb.grid(column =0, row=0)
    
    #This function opens the Guide window to help the main user
    def helpGuide(self):
        help_app = Tk()
        help_app.title('LEMT Circuit Simulator Guide')
        guide = open('Guide.txt', 'r') 
        lines = []
        for line in guide:
            lines.append(line[:-1])
        print (lines)
        guide_text = ''
        for item in lines:
            line = item + '\n'       
            guide_text = guide_text + line
        print (guide_text)
        lb = Label(help_app, text= guide_text)
        lb.grid(column =0, row=0)
        guide.close()

    
#Defining the restart option. It restart all the program data once memorized
    
#Dropdown Menu for units___________________________________________________________
unitsDic= {'m':10**-3, 'µ':10**-6, 'n':10**-9, 'p':10**-9, '-':1, 'k':10**3, 'M':10**6, 'G':10**9, 'T':10**12}

class dropdownMenu:
    def __init__(self, window, unitEl):
        self.__window = window
        self.__type = unitEl
        
    def dropdown(self, window,row=0,unit = ''):
        global variable
        if unit == '':
            unit = self.__type
        units = [
            'm'+(unit),
            'µ'+(unit),
            'n'+(unit),
            'p'+(unit),
            '-'+(unit),
            'k'+(unit),
            'M'+(unit),
            'G'+(unit),
            'T'+(unit)
        ]
    
        variable = StringVar(window)
        variable.set('-'+(unit)) # default value
        w = OptionMenu(window, variable, *units)
        w.grid(row = row, column = 3)
        
    def select(self):
        global unitSelected
        unitSelected = variable.get()
        print ("Unit is: " + unitSelected)

    def elementUnit(self, value):
        self.__value = value
        global stringValue
        global nominalValue
        nominalValue = self.__value*unitsDic[unitSelected[0]]
        print (nominalValue)
        if unitSelected[0] == '-':
            stringValue = str(nominalValue)
        else:
            stringValue = str(self.__value) + ' ' + unitSelected[0]
        print (stringValue)
  
  ##__________________________________________________________________________________________________________________

timeStepLabel=Label(frameUp,text='Time Step',bg='white')
timeStepLabel.grid(column=3, row=0, padx=5,pady=5)
timeStepRequest=Entry(frameUp)
timeStepRequest.grid(column=4, row=0, padx=5,pady=5)

simulationTimeLabel=Label(frameUp,text='Simulation time',bg='white')
simulationTimeLabel.grid(column=5, row=0, padx=5,pady=5)
simulationTimeRequest=Entry(frameUp)
simulationTimeRequest.grid(column=6, row=0, padx=5,pady=5)
time=0

circuitNameLabel=Label(frameUp,text = 'Project name',bg='white')
circuitNameLabel.grid(column=7, row=0, padx=5,pady=5)
circuitNameRequest = Entry(frameUp)
circuitNameRequest.grid(column=8, row=0, padx=5,pady=5)
circuitName = ''

precision = tkinter.StringVar(None,'Simple')
precisionSelectLabel=Label(frameUp,text = 'Precision',bg='white')
precisionSelectLabel.grid(column=9, row=0, padx=5,pady=5)
precisionSelectSimple=Radiobutton(frameUp, text = 'Simple', variable = precision, value='Simple',bg='white')
precisionSelectSimple.grid(column=10, row=0, padx=5,pady=5)
precisionSelectDouble=Radiobutton(frameUp, text = 'Double', variable = precision, value='Double',bg='white')
precisionSelectDouble.grid(column=11, row=0, padx=5,pady=5)

HLSworkspace = ''
lista = []

def registrar_nos(event):   #Missing the part where we check if the circuit is open!
    global reddot
    global elements
    global nodes_images
    global wires_2
    global wires
    global nos
    global nos_id
    global element_location
    global pontos
    global element_location_end
    global element_location_start
    global greendots
    global timeStepRequest
    global simulationTimeRequest
    global time
    global wires_id
    global lista
    global circuitName
    #Creating wires list
    wires=[]
    
    try:
        time = simulationTimeRequest.get().replace(',','.') #Let the user type , instead of . if he wants
        h = timeStepRequest.get().replace(',','.') #the same from above
        time = float(time) #try to converts the time to float, once it´s a string
        h=float(h) #same from above
    except:
        messagebox.showerror('Simulation Error','Please Insert a valid simulation time and time step!')
        return None
    
    circuitName = circuitNameRequest.get()
    print(circuitName)
    if circuitName == '':
        messagebox.showerror('Simulation Error','Please name your project!')
        return None
    for c in ['[',']','{','}','"',"'",'\\','/','.']:
        if c in circuitName:
            print(c)
            messagebox.showerror('Simulation Error','Your project name contains invalid characters!')
            return None
    
    wires_origin=wires[:]
    #reseting lists
    element_location=[]
    nos_id=[]
    element_location_start=[]
    element_location_end=[]
    nos=[]
    pontos=[]
    wires_2=[]
    wires_3=[]
    wires_list=[]
    
        #--------------------------------------------------
    
    #CHECK IF THERE IS ANY ELEMENT BETWEEN THE TWO ENDS OF A WIRE AND CONNECTS IT WITH TWO WIRES

    wire_list=[]
    wires_2=wires_origin[:]
    wires_3=wires[:]
    wires_remove=[]

    #removing old greendots:
    for elemento in greendots:
        canvas.delete(elemento)
    greendots=[]


    for w in wires_id: #This loop makes the program cut a wire in half if there is a T wire form.
        otherwires=wires_id[:]
        otherwires.remove(w)
        for w2 in otherwires:
            if dot_in_wire(canvas.coords(w)[:2],w2):
                
                wnew=canvas.create_line(canvas.coords(w)[0],canvas.coords(w)[1],canvas.coords(w2)[0],canvas.coords(w2)[1],width=1.5)
                wnew2=canvas.create_line(canvas.coords(w)[0],canvas.coords(w)[1],canvas.coords(w2)[2],canvas.coords(w2)[3],width=1.5)
                canvas.delete(w2)
                wires_id.remove(w2)
                wires_id.append(wnew)
                wires_id.append(wnew2)
                
            elif dot_in_wire(canvas.coords(w)[2:4],w2):

                wnew=canvas.create_line(canvas.coords(w)[2],canvas.coords(w)[3],canvas.coords(w2)[0],canvas.coords(w2)[1],width=1.5)
                wnew2=canvas.create_line(canvas.coords(w)[2],canvas.coords(w)[3],canvas.coords(w2)[2],canvas.coords(w2)[3],width=1.5)
                canvas.delete(w2)
                wires_id.remove(w2)
                wires_id.append(wnew)
                wires_id.append(wnew2)

    for n in wires_id:
        wires.append(tuple(canvas.coords(n)))
    
    
#----------------------------------

    for elemento in elements:
        print(elemento.name)

    
    print(elements_name)
    
    for wire in wires:
        pontos.append((wire[0:2]))
        pontos.append((wire[2:4]))
    pontos_repetidos=pontos[:]
    for elemento in pontos:
        n=pontos.count(elemento)
        if n>1:
            while n>1:
                pontos.remove(elemento)
                n=pontos.count(elemento)
    
    #DELETING OLD NODES FROM NODE LIST (nos):
    
    for elemento in nodes_images:
        canvas.delete(elemento)
        
    for elemento in greendots:
        canvas.delete(elemento)
            
    #EVERY WIRE AND ELEMENT CONNECTION RECEIVES A NODE:
    for elemento in pontos:
        for obj in elements:
            if obj.start==elemento:
                nos.append(elemento)

            if obj.end==elemento:
                nos.append(elemento)
                
    #REMOVING REPEATED NODES IF THERE ARE ANY:
    for elemento in nos:
        n=nos.count(elemento)
        if n>1:
            while n>1:
                nos.remove(elemento)
                n=nos.count(elemento)

    wires_2=wires[:]

    #CORRECTING THE NODES:

        #given any coordinate, the program checks in there is a wire that starts or ends in that place.
            #if there is, the program will get the other end of that wire and repeat the process with it.
            #if there are two or more wires in that point, the program creates a list for the next coordinates it will check.
    
    def follow_wire(ponto,n):   #in the function we use the n parameter. n=0 indicates there were no nodes yet. n>0 indicates that
                                #there is a node before the coordinate we are analysing
        newpontos=[]
        if ponto in nos and n>0:
            nos.remove(ponto)
        #if the coordinate is in the nodes list and n=0 (no nodes created before)
        elif ponto in nos and n==0:
            n+=1
        #now we are cloning the list wires_2 to a list wires_3. so that the list doesnt change in the following
        #for loop.
        wires_3=wires_2[:]
        for wire in wires_3:
            if (wire[0:2])==ponto:
                newponto=(wire[2:4])
                d=canvas.create_image(newponto[0],newponto[1],image=greendot)
                newpontos.append(newponto)
                wires_2.remove(wire)
                greendots.append(d)
                
            elif (wire[2:4])==ponto:
                newponto=(wire[0:2])
                d=canvas.create_image(newponto[0],newponto[1],image=greendot)
                newpontos.append(newponto)
                wires_2.remove(wire)
                greendots.append(d)
        #if there was any wire found, the functions does the process all over again for every coordinate found.
        if len(newpontos)!=0:
            for coord in newpontos:
                follow_wire(coord,n)
                
        #CALLING THE NODE CORRECTION:   
    nos_2=nos[:]
    for p in nos_2:
        follow_wire(p,0)
    print('1nos: ',nos)
    
    for p in nos:
        node_image=canvas.create_image(p[0],p[1],image=reddot)
        nodes_images.append(node_image)
    
    #giving names to each node coordinate
    wires_2=wires
    print('1:',nos_id)
    #LOCATING GROUND NODE:
    def locate_ground(ponto,wireslist):
        global nos
        global nos_id
        newpontos=[]
        wires_3=wireslist[:]
        new_id=['N0',ponto]
        if ponto in nos and new_id not in nos_id:
            nos_id.append(new_id)
        for wire in wireslist:
            if (wire[0:2])==ponto:
                newponto=(wire[2:4])
                newpontos.append(newponto)
                wires_3.remove(wire)               
            elif (wire[2:4])==ponto:
                newponto=(wire[0:2])
                newpontos.append(newponto)
                wires_3.remove(wire)
        if len(newpontos)!=0:
            for n in newpontos:
                locate_ground(n,wires_3)
                
    for elemento in elements:
        if elemento.name[0]=='G':
            locate_ground(elemento.start,wires_2)
    
 #NAMING ALL NODES (Ground node was named before)
    if len(nos_id)!=0: #Ground node connected
        for p in nos:
            if p!=nos_id[0][1]:
                nos_id.append(['N{}'.format(len(nos_id)),p])     
                
    else:#No ground node
        for p in nos:
            nos_id.append(['N{}'.format(len(nos_id)+1),p])  
            
    print('3:',nos_id)

    #in the returnnode function return the node associated with a given point of the circuit
    
    def returnnodeaux(array,ponto,lwires): #Auxiliate function!
        locwires=lwires[:]
        locwires_2=locwires[:]
        for n in nos_id: 
            if ponto==n[1]: #if the given location is a node
                if len(array)==0:
                    print('ponto, no',ponto, n[0])
                    array.append(n[0])        
        nextlocations=[]
        for w in locwires:
            if ponto ==(w[0:2]):
                otherend=(w[2:4])
                if w in locwires_2:    
                    locwires_2.remove(w)
                nextlocations.append(otherend)     
            elif ponto ==(w[2:4]):
                otherend=(w[0:2])
                if w in locwires_2:
                    locwires_2.remove(w)
                nextlocations.append(otherend)    
        if len(nextlocations)!=0:
            for i in nextlocations:
                returnnodeaux(array,i,locwires_2)
                
    def returnnode(ponto):#Finds the number of the node associated with a given point in the canvas
        global wires
        L=[]
        returnnodeaux(L,ponto,wires)
        if len(L)!=0:
            return L[0] 
    
    for e in elements:
        if e.name!='Ground':
            print(e.name,returnnode(e.start),returnnode(e.end))
        


    groundList = [] #List checks if there is a ground on canvas
    groundListConnect = [] #List checks if ground is conected to the circuit
    element_location=[]
    
    
    for objeto in elements:
        a='N1'
        b='N1'
        if objeto.name[0] == 'G':
            groundList.append(1)  
            
        if objeto.name[0] != 'G' and objeto.name[0] not in ('A','B'): #P/ fonte alternada é diferente
            a=returnnode(objeto.start)
            b=returnnode(objeto.end)
            print('objeto',objeto.name,a,b)
            print('start e end',objeto.start,objeto.end)
            
            element_location.append([int(a[1:]),int(b[1:]),objeto.name,objeto.value])
            
        if objeto.name[0] == 'A': #P/ fonte alternada
            a=returnnode(objeto.start)
            b=returnnode(objeto.end)
            
            print('objeto',objeto.name,a,b)
            element_location.append([int(a[1:]),int(b[1:]),objeto.name,objeto.value,objeto.frequency,objeto.phase,objeto.offset])
        
        if objeto.name[0] == 'B': #P/ fonte alternada
            a=returnnode(objeto.start)
            b=returnnode(objeto.end)
            
            print('objeto',objeto.name,a,b)
            element_location.append([int(a[1:]),int(b[1:]),objeto.name,objeto.value,objeto.frequency,objeto.phase,objeto.offset])
            
    for element in element_location:
        print(element)
    
    #__________________Find where Voltmeters are___________________
    
    simulationnodes={}
   
    for e in  element_location[:]:
        if e[2][:-1]=='VM': #Voltmeter
            
            simulationnodes[e[2]]='V{}'.format(e[0])
            element_location.remove(e) #Removes voltmeter form netlist 
    
    


    
#_______ERROR interpretator of the simulator_______________________________________________________________

    def readCircuit():
        global groundListConnect
        global errorList
        global iSourceList
        global vSourceList
        
        

        
        errorList = [] 
        groundListConnect = []
        vSourceList = []
        iSourceList = []
        for item in element_location:
            typeEl = item[2]
            if item[2][:-1]!='VM':
                if item[0] == 0 or item[1] == 0:
                    groundListConnect.append(1)
                    #fazer fontes paralelas
                if item[0] == item[1]:
                    messagebox.showerror('SHORT CIRCUIT', 'There is a component positive terminal conected to the negative one! Review your Circuit!')
                    errorList.append(1)        
                    
    def noElement():
        if len(element_location) == 0:
            messagebox.showerror('NOTHING IS GONNA HAPPEN', 'There is no Component on your screen! \nSelect the components of the circuit and simulate it again!')
            errorList.append(1)
        return
    def groundError():
        if elements_name.count('Ground') == 0:
            messagebox.showerror('GROUND ERROR', 'The circuit need to be grounded! \nPlease select GROUND on tools and conect the element to the circuit')  
            errorList.append(1)
        if elements_name.count('Ground') > 0:
            k=0
            for node in nos_id:
                if node[0][1]=='0':
                    k+=1
            if k==0:
                messagebox.showerror('GROUND ERROR', 'The circuit need to be grounded! \nPlease conect the GROUND to the circuit')
                errorList.append(1)
        return


    def circuitOk():
        messagebox.showinfo('SIMULATION', 'The circuit is going to be simulated')
    def checkForError():
        readCircuit()
        while len(errorList) == 0:
            noElement()
            if len(errorList)==0:
                groundError()
            break
        if len(errorList) == 0:
            circuitOk()

    checkForError()
    print('element loc',element_location)
    
    
    ####################### SOLVER ##############
    lista = element_location[:]
    
    print('Velha lista: ', lista)
    for n in lista:
        for e in range(len(n)):
            if type(n[e]) not in (int,float):
                unidade=n[e][-1]
                if unidade in unitsDic.keys():
                    i=n[e].index(unidade)
                    newvalue=float(n[e][:i])*unitsDic[unidade]
                    n[e]=newvalue
                else:
                    try:
                        print('AGORA: ', n[e])
                        n[e]=float(n[e])
                    except:
                        print('deu')
                        pass                    
    numeros=[]
    for n in lista:
        numeros.append(n[0])
        numeros.append(n[1])

    ########################################################################
    novalista=copy.deepcopy(lista)
    contC=1
    contL=1
    contR=0
    
    for n in novalista:
        if n[2][0] == 'R':
            contR+=1
            
    contCL=contC+contR
    
    for n in novalista:
        if n[2][0] == 'C':
            n[2] = 'R' + str(contCL)
            n[3] = h/(2*n[3])
            contCL+=1
                
        if n[2][0] == 'L':
            n[2] = 'R' + str(contCL)
            n[3] = 2*n[3]/h
            contCL+=1

    print('NovaNetList:',novalista)
    print('Netlist: ', lista)
    
    
    LC=0
    for i in lista:
        if i[2][0]=='L' or i[2][0]=='C':
            LC+=1

    ########################################################################
    
    m=max(numeros)
    A=np.zeros((m,m))
    Z=np.zeros((m,1)) #Matriz da direita
    positionL=[]
    positionC=[]
    positionA=[]
    for line in lista:
        if line[2][0]=='R':
            if line[0]!=0:
                A[line[0]-1][line[0]-1]+=1.0/line[3]
            if line[1]!=0:
                A[line[1]-1][line[1]-1]+=1.0/line[3]
            
            if line[0]!=0 and line[1]!= 0:
                A[line[0]-1][line[1]-1]-=1.0/line[3]
                A[line[1]-1][line[0]-1]-=1.0/line[3]
           
        #Line for a V (voltage source) in the matrix
        if line[2][0]=='V':
            n=np.zeros((1,A.shape[1]))
            if line[0]!=0:
                n[0][line[0]-1]=1
            if line[1]!=0:
                n[0][line[1]-1]=-1
            nv=np.zeros((1,1))
            nv[0][0]=line[3] #Voltage
            Z=np.concatenate((Z,nv),axis=0)
           
            A=np.concatenate((A,n),axis=0) 
            n2=np.zeros((A.shape[0],1))
            if line[0]!=0:
                n2[line[0]-1][0]= 1
            if line[1]!=0:
                n2[line[1]-1][0]= -1
            A=np.concatenate((A,n2),axis=1)
            
        if line[2][0]=='A':
            n=np.zeros((1,A.shape[1]))
            if line[0]!=0:
                n[0][line[0]-1]=1
            if line[1]!=0:
                n[0][line[1]-1]=-1
            nv=np.zeros((1,1))
            nv[0][0]=line[3]*math.sin(line[4]*0 + line[5]) #Voltage
            Z=np.concatenate((Z,nv),axis=0)
           
            A=np.concatenate((A,n),axis=0) 
            n2=np.zeros((A.shape[0],1))
            if line[0]!=0:
                n2[line[0]-1][0]=1
            if line[1]!=0:
                n2[line[1]-1][0]=-1
            A=np.concatenate((A,n2),axis=1)
            positionA.append([int(A.shape[0]),line[3],line[4],line[5],line[6]]) # The lists inside are [number of line in matrix A, voltage, frequency, phase, offset]
            
    ############################################  
        if line[2][0]=='L':
            n=np.zeros((1,A.shape[1]))
            if line[0]!=0:
                n[0][line[0]-1]=1
            if line[1]!=0:
                n[0][line[1]-1]=-1
            
            A=np.concatenate((A,n),axis=0) 
            n2=np.zeros((A.shape[0],1))
            linha=n2.shape[0]-1
            fator=line[3]
            n2[linha][0]=-fator/h
            if line[0]!=0:
                n2[line[0]-1][0]=1
            if line[1]!=0:
                n2[line[1]-1][0]=-1  
            A=np.concatenate((A,n2),axis=1)
            new=np.zeros((1,1))
            Z=np.concatenate((Z,new),axis=0)
            positionL.append(int(A.shape[0]))
        
    #############################################
        if line[2][0]=='C':
            n=np.zeros((1,A.shape[1]))
            if line[0]!=0:
                n[0][line[0]-1]=-float(line[3])/h
            if line[1]!=0:
                n[0][line[1]-1]=float(line[3])/h
    
            A=np.concatenate((A,n),axis=0) 
            
            n2=np.zeros((A.shape[0],1))
            linha=n2.shape[0]-1
            if line[0]!=0:
                n2[line[0]-1][0]=1
            if line[1]!=0:
                n2[line[1]-1][0]=-1
            n2[A.shape[0]-1][0]=1 
            A=np.concatenate((A,n2),axis=1)
            nl=np.zeros((1,1))
            
            new=np.zeros((1,1))
            Z=np.concatenate((Z,new),axis=0)
            positionC.append(int(A.shape[0]))
            
    #############################################
        if line[2][0]=='I':
            if line[0]!=0:
                Z[line[0]-1][0]=line[3]
            if line[1]!=0:
                Z[line[1]-1][0]=-line[3]
                
    #######################################################
    ################## AM MATRIX CRIATION #################
    #######################################################
           
    Am=np.zeros((m,m))
    positionLm=[]
    positionCm=[]
    positionAm=[]
    for line in novalista:
        if line[2][0]=='R':
            if line[0]!=0:
                Am[line[0]-1][line[0]-1]+=1.0/line[3]
            if line[1]!=0:
                Am[line[1]-1][line[1]-1]+=1.0/line[3]
            
            if line[0]!=0 and line[1]!= 0:
                Am[line[0]-1][line[1]-1]-=1.0/line[3]
                Am[line[1]-1][line[0]-1]-=1.0/line[3]
           
        #Line for a V (voltage source) in the matrix
        if line[2][0]=='V':
            n=np.zeros((1,Am.shape[1]))
            if line[0]!=0:
                n[0][line[0]-1]=1
            if line[1]!=0:
                n[0][line[1]-1]=-1
            nv=np.zeros((1,1))
            nv[0][0]=line[3] #Voltage
           
            Am=np.concatenate((Am,n),axis=0) 
            n2=np.zeros((Am.shape[0],1))
            if line[0]!=0:
                n2[line[0]-1][0]= 1
            if line[1]!=0:
                n2[line[1]-1][0]= -1
            Am=np.concatenate((Am,n2),axis=1)
            
        if line[2][0]=='A':
            n=np.zeros((1,Am.shape[1]))
            if line[0]!=0:
                n[0][line[0]-1]=1
            if line[1]!=0:
                n[0][line[1]-1]=-1
            nv=np.zeros((1,1))
            nv[0][0]=line[3]*math.sin(line[4]*0 + line[5]) #Voltage
           
            Am=np.concatenate((Am,n),axis=0) 
            n2=np.zeros((Am.shape[0],1))
            if line[0]!=0:
                n2[line[0]-1][0]=1
            if line[1]!=0:
                n2[line[1]-1][0]=-1
            Am=np.concatenate((Am,n2),axis=1)
            positionAm.append([int(Am.shape[0]),line[3],line[4],line[5]]) # The lists inside are [number of line in matrix A, voltage, frequency, phase]
            
    ############################################  
        if line[2][0]=='L':
            n=np.zeros((1,Am.shape[1]))
            if line[0]!=0:
                n[0][line[0]-1]=1
            if line[1]!=0:
                n[0][line[1]-1]=-1
            
            Am=np.concatenate((Am,n),axis=0) 
            n2=np.zeros((Am.shape[0],1))
            linha=n2.shape[0]-1
            fator=line[3]
            n2[linha][0]=-fator/h
            if line[0]!=0:
                n2[line[0]-1][0]=1
            if line[1]!=0:
                n2[line[1]-1][0]=-1  
            Am=np.concatenate((Am,n2),axis=1)
            new=np.zeros((1,1))
            positionLm.append(int(Am.shape[0]))
        
    #############################################
        if line[2][0]=='C':
            n=np.zeros((1,Am.shape[1]))
            if line[0]!=0:
                n[0][line[0]-1]=-float(line[3])/h
            if line[1]!=0:
                n[0][line[1]-1]=float(line[3])/h
    
            Am=np.concatenate((Am,n),axis=0) 
            
            n2=np.zeros((Am.shape[0],1))
            linha=n2.shape[0]-1
            if line[0]!=0:
                n2[line[0]-1][0]=1
            if line[1]!=0:
                n2[line[1]-1][0]=-1
            n2[A.shape[0]-1][0]=1 
            Am=np.concatenate((Am,n2),axis=1)
            nl=np.zeros((1,1))
            
            new=np.zeros((1,1))
            positionCm.append(int(Am.shape[0]))
    
    #########################################################
    ############### ENVIO PARA PIPELINE #####################
    #########################################################
    #try:
    path = 'Script Pipeline\\'
    net = open(path + 'netList.txt','wb')
    listaPipe = lista.copy()
    listaPipe.append(h)
    name = circuitName
    listaPipe.append(name)
    listaPipe.append(time)
    p = precision.get()
    if p == 'Double':
        listaPipe.append(2)
    else:
        listaPipe.append(1)
    listaPipe.append(HLSworkspace)
    pickle.dump(listaPipe, net)
    print('lista',listaPipe)
    net.close()
    matrix = open(path + 'Am.txt','wb')
    pickle.dump(Am,matrix)
    matrix.close()
    code = open(path + 'generatorHLS.py','r').read()
    exec(code)
    print('NetList exportada com sucesso!')
    #except:
        #print('Falha na exportação do netlist!')
    
    
    #####################################################
    ################## CREATING VECTOR H ################
    #####################################################

    Zm = np.zeros((m,1))
    vsources=0
    i=1
    contA=0
    
    for l in lista:
        if l[2][0] == 'V' or l[2][0] == 'A':
            vsources+=1
        if l[2][0] == 'A':
            contA+=1

    aux = np.zeros((vsources,1))

    while i <= m:
        for l in lista:
            if l[2][0] == 'I':
                if l[0] == i:
                    Zm[i-1][0]+=l[3]
                if l[1] == i:
                    Zm[i-1][0]-=l[3]
        i+=1
    i=1

    for l in lista:
        if l[2][0] == 'V':
            aux[i-1][0] = l[3]
            i+=1

    Zm = np.concatenate((Zm,aux))
    print('Zm:',Zm)
        
    
    #######################################################

    def floatToIEEE754(n):
        if float(n) == 0.0:
            return '0'*32
        S = '0'
        if n<0:
            S = '1'
            n *= -1   
        inter = int(n)
        frac = n%1
        interB = bin(inter)[2:]
        fracB = ''
        while frac!=0:
            fracB += str((frac*2)//1)[0]
            frac = (frac*2)%1
        if interB != '0':
            E = len(interB)-1 + 127
            E = bin(E)[2:]
            M = interB[1:] + fracB
        elif interB == '0':
            E = 127 - (fracB.find('1')+1)
            E = bin(E)[2:]
            M = fracB[fracB.find('1')+1 :]       
        E = '0'*(8-len(E)) + E
        if len(M)<23:
            M += '0'*(23-len(M))
        elif len(M)>23:
            M = M[:22] + '1'   
        return S + E + M

    
    Aminv = inv(Am)
    print('Z',Z)
    print('A:',A)
    print('Am',Am)
    print('Aminv:',Aminv)
    

    coe_file = open('coe_file_teste4.coe','w')

    coe_file.write('; Sample Initialization file for a 16x32 distributed ROM\n; this memory stores the inverted conductance matrix\n; this is instantiated inside vetmat module\nmemory_initialization_radix = 2;\nmemory_initialization_vector =\n\n')

    cont=0
    elem=0
    linhas=0
    
    for linha in Aminv:
        coe_file.write('; ')
        linhas+=1
        for elemento in linha:
            elemento=str(elemento)
            coe_file.write(elemento)
            coe_file.write(3*'\t')
        coe_file.write('\n')

    termos=linhas*linhas

    for linha in Aminv:
        for elemento in linha:
            if cont!=0 and cont%2==0 and cont!= termos:
                coe_file.write('\n')
            elemento=str(floatToIEEE754(elemento))
            coe_file.write(elemento)
            elem+=1
            coe_file.write(' ')
            cont+=1
    
    coe_file.write(';')
    coe_file.close()
    
    
    tramcoe = open('tRam_teste4.coe','w')
    tramcoe.write('; Sample Initialization file for a 16x128 blocked RAM\n; this memory stores the AC senoidal sources information. It is instantiated in main module\nmemory_initialization_radix = 2;\nmemory_initialization_vector =\n\n; w.t (32b) + current phase (32b) + amplitude (32b) + DC offSet(32b)\n; "w" is the angular frequency and "t" is the integration pass \n\n')
    nodes = open('nodes_teste4.coe','w')
    nodes.write('; Sample Initialization file for a 16x32 distributed ROM\n; this memory stores L and C information. It is instantiated in histvect module\n; P (1b) P = 0 inductor P = 1 Capacitor node+ (16b) node- (16b) 2/Req (32b)\nmemory_initialization_radix = 2;\nmemory_initialization_vector =\n\n')
    veth = open('vectorH_teste4.coe','w')
    veth.write('; Sample Initialization file for a 16x32 distributed RAM\n; this memory stores I vector. It is instantiated in main module\nmemory_initialization_radix = 2;\nmemory_initialization_vector =\n\n;')
    irom = open('i_rom_teste4.coe','w')
    irom.write('; Sample Initialization file for a 16x32 distributed ROM\n; this memory stores I vector. It is instantiated in main module\nmemory_initialization_radix = 2;\nmemory_initialization_vector =\n\n;')
    vetv = open('vectorV_teste4.coe','w')
    vetv.write('; Sample Initialization file for a 16x32 distributed ROM\n; this memory stores V vector. It is instantiated in main module\nmemory_initialization_radix = 2;\nmemory_initialization_vector =\n\n')
    hist = open('hist_teste4.coe', 'w')
    hist.write('; Sample Initialization file for a 16x32 distributed ROM\n; this memory stores the historical current sources associated to each element of L and C (nodes file)\n; this is instantiated inside histvect module\nmemory_initialization_radix = 2;\nmemory_initialization_vector =\n\n')
    
    
    contsub=1
    cont=1
    for element in lista:
        if element[2][0] == 'A':
            if cont!=contA:
                tramcoe.write(str(floatToIEEE754(2*np.pi*element[4]*1e-6))+str(floatToIEEE754(element[5]))+str(floatToIEEE754(element[3]))+str(floatToIEEE754(element[6]))+'\n')
                cont+=1
            else:
                tramcoe.write(str(floatToIEEE754(2*np.pi*element[4]*1e-6))+str(floatToIEEE754(element[5]))+str(floatToIEEE754(element[3]))+str(floatToIEEE754(element[6]))+';')
                        
        if element[2][0] == 'L':
            nodes.write('0'+(18-len(str(bin(element[0]))))*'0'+str(bin(element[0]))[2:]+(18-len(str(bin(element[1]))))*'0'+str(bin(element[1]))[2:]+str(floatToIEEE754(h/element[3])))
            if contsub != LC:
                nodes.write('\n')
                contsub+=1

        if element[2][0] == 'C':
            nodes.write('1'+(18-len(str(bin(element[0]))))*'0'+str(bin(element[0]))[2:]+(18-len(str(bin(element[1]))))*'0'+str(bin(element[1]))[2:]+str(floatToIEEE754(4*element[3]/h)))
            if contsub != LC:
                nodes.write('\n')
                contsub+=1

    nodes.write(';')


    for linha in Zm:
        for element in linha:
            veth.write(str(element)+' ')
            irom.write(str(element)+' ')
    veth.write('\n\n')
    irom.write('\n\n')

    cont=0
    for line in Zm:
        for element in line:
            if cont%2==0 and cont!=linhas-1:
                irom.write(floatToIEEE754(element)+' ')
                cont+=1
            elif cont%2==1 and cont!=linhas-1:
                irom.write(floatToIEEE754(element)+'\n')
                cont+=1
            elif cont==linhas-1:
                irom.write(floatToIEEE754(element)+';')


    hist.write('; ' + LC*'0 ' + '\n')

    cont=0
    for i in range(LC):
        if cont % 2 == 1 and i != (LC-1):
            hist.write(32*'0'+'\n')
            cont+=1
        elif cont % 2 == 0 and i != (LC-1):
            hist.write(32*'0'+' ')
            cont+=1
        else:
            hist.write(32*'0'+';')


    vetv.write('; '+linhas*'0 '+'\n')
    veth.write('; '+linhas*'0 '+'\n')

    cont=0
    for i in range(linhas):
        if cont%2==0 and cont!=linhas-1:
            vetv.write(32*'0'+' ')
            veth.write(32*'0'+' ')
            cont+=1
        elif cont%2==1 and cont!=linhas-1:
            vetv.write(32*'0'+'\n')
            veth.write(32*'0'+'\n')
            cont+=1
        elif cont==linhas-1:
            vetv.write(32*'0'+';')
            veth.write(32*'0'+';')

         
    tramcoe.close()
    nodes.close()
    veth.close()
    irom.close()
    hist.close()
    vetv.close()

##########################################################################################
    #SOLUCAO#
    ##########################################################################################
    dV={}
    for n in range(0,m+1): #From V0 to Vn
        dV['V{}'.format(n)]=[]
        
    iteracoes=int(round(time/h))
    
    timeList=[] #Time array
    for i in range(iteracoes):
        timeList.append(i*h)
    print(timeList)
    Ainv = np.linalg.inv(A) #Creates the Inverse of A matrix
    
    for timeunit in timeList: # starting resolution loop !!!
        x = np.dot(Ainv,Z) #Multiplies the known matrices
        
        for key in dV:
            if key !='V0':
                dV[key].append(x[int(key[1])-1][0]) 
            else: 
                dV[key].append(0)
                
    #   print('Z: ', Z)
        for n in positionC: #For every Capacitor line in the A matrix, the code looks for the   
            line=A[n-1][:n-2]  #positive and negative node and get their Voltage in the X matrix
    #        print(line)
            nNode=0
            pNode=0
            
            for i in range(1,len(line)+1) :
                if line[i-1]<0:
                    nNode=i
                if line[i-1]>0:
                    pNode=i
            if pNode!=0:
                Vk=x[pNode-1][0]
                fator=A[n-1][pNode-1] # c/h
            else:
                Vk=0
                fator=-A[n-1][nNode-1] # c/h
            if nNode!=0:
                Vm=x[nNode-1][0]
            else:
                Vm=0
                
    #        print('c/h: ',fator,'V1: ', V1,'V2: ',V2)
            Z[n-1][0]=fator*(Vk-Vm)
        for n in positionL: #For every Capacitor line in the A matrix, the code looks for the   
            line=A[n-1][:]  #positive and negative node and get their Voltage in the X matrix
            
            iL=x[n-1][0]
            fator=A[n-1][n-1] # -l/h
            Z[n-1][0]=fator*iL 
            
        for n in positionA:
            fator=n[1]*math.sin(n[2]*2*math.pi*timeunit + n[3])
            Z[n[0]-1][0]=fator
    
   
    for n in dV:
        print(n,':',dV[n])
        
    for voltmeter_name in simulationnodes:
        win=Tk()
        win.geometry('600x530+300+50') 
        win.title('LEMT CIRCUIT SIMULATOR')
        figure=Figure(figsize=(9,7),dpi=70)
        figure.suptitle('Voltage x Time in {}'.format(voltmeter_name))
        a=figure.add_subplot(111)
        a.plot(timeList,dV[str( simulationnodes[voltmeter_name] )])
        a.grid()
        print('oi')
        canvasplot=FigureCanvasTkAgg(figure,master=win)
        canvasplot.get_tk_widget().pack(fill=BOTH)
        canvasplot.draw()
        toolbar = NavigationToolbar2Tk(canvasplot,win)
        toolbar.update()
        canvasplot._tkcanvas.pack()
        
    wires=wires_origin[:]

#                 class      icon   name   position of button     text and unit
def create_button(class_name, img,name, textunit , unit):
                                                                          #To avoid repeating the code for every new
    _class=globals()[class_name]                                          #button we created a function for it.
                                                                                                                                      
    def button_action(event):
        window = Tk()
        window.geometry('300x50+400+200')
        window.title('{} creator'.format(name))
        entry=Entry(window)
        entry.grid(row=0,column=1)
        lbUnit = Label(window, text=textunit )
        lbUnit.grid(row=0, column = 4)
        
        dropdown = dropdownMenu(window, unitEl=unit)
        
        def validate():
            entryValue = entry.get().replace(',','.')
            try:
                entryValue = float(entryValue)
            except ValueError:
                messagebox.showerror('INVALID ENTRY!', 'Please enter a NUMBER!')
                entry.delete(0, 'end')
                window.lift()
            if type(entryValue) == float or type(entryValue) == int:
                closeWindow()
        def closeWindow(x=window,y=entry):
            entryValue = float(entry.get().replace(',','.'))
            dropdown.select()
            dropdown.elementUnit(value = entryValue)
            entryValue = stringValue
            print (entryValue)
            _object = _class(entryValue)
            window.destroy()
    
        frame = Frame(window)
        frame.grid(row=0,column=0) 
        
        create_button = Button (frame, text = "Create", command = validate)
        create_button.grid(row=0,column=0)
        dropdown.dropdown(window)
        
    
    
    button=Button(frameLeft,image=img, compound='top', width=50)
    button.bind('<ButtonPress-1>',button_action)
    button.pack(side=TOP,padx=5,pady=5)
    
 



def create_button_novalues(class_name, icon):
    _class=globals()[class_name]
    def create_instance(event):
        c=_class()
        
    button=Button(frameLeft, image=icon, compound = 'top', width=50)
    button.bind('<ButtonPress-1>',create_instance)
    button.pack(side=TOP, padx=5,pady=5)


def create_ACsource(event):
    window = Tk()
    window.geometry('300x100+400+200')
    window.title('AC source')
    
    entry=Entry(window)
    entry.grid(row=0,column=1)
    lbUnit = Label(window, text='Voltage (V)' )
    lbUnit.grid(row=0, column = 4)
    
    entry2=Entry(window)
    entry2.grid(row=1,column=1)
    lbUnit2 = Label(window, text='Frequency' )
    lbUnit2.grid(row=1, column = 4)
    
    entry3=Entry(window)
    entry3.grid(row=2,column=1)
    lbUnit3 = Label(window, text='Phase' )
    lbUnit3.grid(row=2, column = 4)
    dropdown = dropdownMenu(window, unitEl='V')

    entry4=Entry(window)
    entry4.grid(row=3,column=1)
    lbUnit4 = Label(window, text='Offset' )
    lbUnit4.grid(row=3, column = 4)
    
    def validate():
        entryValue = entry.get().replace(',','.')
        frequency=entry2.get().replace(',','.')
        phase=entry3.get().replace(',','.')
        offset=entry4.get().replace(',','.')
        
        try:
            entryValue = float(entryValue)
            frequency = float(frequency)
            phase = float(phase)
            offset = float(offset)
            closeWindow()
        except ValueError:
            messagebox.showerror('INVALID ENTRY!', 'Please enter a NUMBER!')
            entry.delete(0, 'end')
            window.lift()
            
    def closeWindow(x=window,y=entry):
        entryValue = float(entry.get().replace(',','.'))
        frequency=entry2.get().replace(',','.')
        phase=entry3.get().replace(',','.')
        offset=entry4.get().replace(',','.')
        
        dropdown.select()
        dropdown.elementUnit(value = entryValue)
        entryValue = stringValue
        
        print (entryValue)
        ACvoltage=ACsource(entryValue,frequency,phase,offset)
        window.destroy()
        
    frame = Frame(window)
    frame.grid(row=0,column=0)
    button = Button (frame, text = "Create", command = validate)
    button.grid(row=0,column=0)
    dropdown.dropdown(window)


def create_Current_ACsource(event):
    window = Tk()
    window.geometry('300x100+400+200')
    window.title('AC current source')
    
    entry=Entry(window)
    entry.grid(row=0,column=1)
    lbUnit = Label(window, text='Current (A)' )
    lbUnit.grid(row=0, column = 4)
    
    entry2=Entry(window)
    entry2.grid(row=1,column=1)
    lbUnit2 = Label(window, text='Frequency' )
    lbUnit2.grid(row=1, column = 4)
    
    entry3=Entry(window)
    entry3.grid(row=2,column=1)
    lbUnit3 = Label(window, text='Phase' )
    lbUnit3.grid(row=2, column = 4)
    dropdown = dropdownMenu(window, unitEl='V')

    entry4=Entry(window)
    entry4.grid(row=3,column=1)
    lbUnit4 = Label(window, text='Offset' )
    lbUnit4.grid(row=3, column = 4)
    
    def validate():
        entryValue = entry.get().replace(',','.')
        frequency=entry2.get().replace(',','.')
        phase=entry3.get().replace(',','.')
        offset=entry4.get().replace(',','.')
        
        try:
            entryValue = float(entryValue)
            frequency = float(frequency)
            phase = float(phase)
            offset = float(offset)
            closeWindow()
        except ValueError:
            messagebox.showerror('INVALID ENTRY!', 'Please enter a NUMBER!')
            entry.delete(0, 'end')
            window.lift()
            
    def closeWindow(x=window,y=entry):
        entryValue = float(entry.get().replace(',','.'))
        frequency=entry2.get().replace(',','.')
        phase=entry3.get().replace(',','.')
        offset=entry4.get().replace(',','.')
        
        dropdown.select()
        dropdown.elementUnit(value = entryValue)
        entryValue = stringValue
        
        print (entryValue)
        ACcurrent = current_ACsource(entryValue,frequency,phase,offset)
        window.destroy()
        
    frame = Frame(window)
    frame.grid(row=0,column=0)
    button = Button (frame, text = "Create", command = validate)
    button.grid(row=0,column=0)
    dropdown.dropdown(window)
    
    
#Here Starts the Button creation of the Left Dashboard
    
CompLabel=Label(frameLeft, text='Components', bg= 'White')
CompLabel.pack(side=TOP,padx=5,pady=5)


acIcon = PhotoImage(file='Icons/AcSourceIcon.png')
button_ACsource=Button(frameLeft,image= acIcon, compound='top',width=50)
button_ACsource.bind('<ButtonPress-1>',create_ACsource)
button_ACsource.pack(side=TOP,padx=5,pady=5)

c_acIcon = PhotoImage(file='Icons/CurrentAcSourceIcon.png')
button_ACsource=Button(frameLeft,image= c_acIcon, compound='top',width=50)
button_ACsource.bind('<ButtonPress-1>',create_Current_ACsource)
button_ACsource.pack(side=TOP,padx=5,pady=5)

icon_dc_source = PhotoImage(file = 'Icons/sourceIcon.png')
create_button('DCVoltagesource',icon_dc_source,'Voltage Source', 'Voltage (V)','V')

icon_current_source = PhotoImage(file = 'Icons/CurrentSourceIcon.png')
create_button('currentSource',icon_current_source,'Current Source','Current (A)','A')

icon_resistor=PhotoImage(file = 'Icons/resistorIcon.png')
create_button('Resistor',icon_resistor,'Resistor','Resistance (Ω)','Ω')
  
icon_inductor=PhotoImage(file = 'Icons/inductorIcon.png')
create_button('Inductor',icon_inductor,'Inductor','Inductance (H)','H')

icon_capacitor=PhotoImage(file = 'Icons/capacitorIcon.png')
create_button('Capacitor',icon_capacitor,'Capacitor','Capacitance (F)','F')

icon_ground= PhotoImage(file = 'Icons/groundIcon.png')
create_button_novalues('Ground',icon_ground)


anLabel=Label(frameLeft, text='Analysis',bg='White')
anLabel.pack(side=TOP,padx=5, pady=5)

icon_voltmeter= PhotoImage(file = 'lemt_greendot.png')
create_button_novalues('Voltmeter',icon_voltmeter)

#future voltimeter and ammeter


#___________________________SHOW NODES BUTTON_________________________________________

button_registrar=Button(frameUp,text="Simulate", bg = 'LightGreen')
button_registrar.bind('<ButtonPress-1>',registrar_nos)
button_registrar.grid(column=0, row=0, padx=5,pady=5)

#_______________________________________________________________________________

if __name__ == "__main__":
    menuSystem(app)
    app.mainloop()

 

 
