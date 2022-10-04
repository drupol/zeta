close all
clear h

graphics_toolkit qt

pkg load symbolic;

function update_plot (obj, event)
  h = guidata (obj);

  a = linspace(0,get(h.imaginary, 'value'),get(h.imaginary, 'value') * get(h.points, 'value'));
  b = 0.5;
  plot(zeta(b+(a*i)));
  xlabel("Real part");
  ylabel("Imaginary part");
  title(sprintf("ζ(%s + %ii)", "0.5", get(h.imaginary, 'value')));

  set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin');
  print -dsvg zeta.svg
  print -dpdf zeta.pdf
  print -dpng zeta.png
  pause
end

h.imaginary = uicontrol(
  'style','slider',
  'position',[10 35 500 50],
  'callback', @update_plot,
  'min', 0,
  'max', 100,
  'value', 50,
  'string', 'Imaginary'
);

h.points = uicontrol(
  'style','slider',
  'position', [10 05 500 50],
  'callback', @update_plot,
  'min', 10,
  'max', 100,
  'value', 10,
  'string', 'Points'
);

guidata (gcf, h);
update_plot(gcf, true);
