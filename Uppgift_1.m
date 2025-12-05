clear all;
close all;

X = load("BatMan.mat").X;

while 1==1

    disp('Vad vill du göra med matrisen:')
    disp('1. Gör en egen figur (default är batman loggan)')
    disp('2. Rotera')
    disp('3. Spegla kring en linje genom origo med angiven vinkel')
    disp('4. Skjuva i x-led')
    disp('5. Skjuva sammansatt')
    disp('6. Roterande animation')
    disp('7. Avsluta programmet')

    menysvar = input('');

    if menysvar == 1
        X = CreateFigure();
    
        save minifig X;
        
        PlotFigure(load("minifig.mat").X);
    end
    
    if menysvar == 2
        tata = input('Hur mycket vill du rotera figuren med?');
        rotationmatris = [cos(tata),-sin(tata);sin(tata),cos(tata)];
        PlotFigure(rotationmatris * X)
    end
    
    if menysvar == 3
        tata2 = input('Vilken vinkel vill du att speglingsaxeln ska ha?');
        spegelmatris = [cos(2*tata2), sin(2*tata2);sin(2*tata2), -cos(2*tata2)];
        PlotFigure(spegelmatris * X)
    end
    
    if menysvar == 4
        k2 = input('Hur mycket vill du skjuva figuren med?');
        skjuvningmatris = [1,k2;0,1];
        PlotFigure(skjuvningmatris * X)
    end

    if menysvar == 5
        k2 = 3;
        tata = pi;
        skjuvningmatris = [1,k2;0,1];
        rotationmatris = [cos(tata),-sin(tata);sin(tata),cos(tata)];
        kombimatris = rotationmatris * skjuvningmatris;
        PlotFigure(kombimatris * X)
    end
    
    if menysvar == 6
        for i = 1:120
            tata = (2*pi)/120*i;
            rotationmatris = [cos(tata),-sin(tata);sin(tata),cos(tata)];
            pause(0.01);
            PlotFigure(rotationmatris * X)
        end
    end

    if menysvar == 7
        break
    end

end