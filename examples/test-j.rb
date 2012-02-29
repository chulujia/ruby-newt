#!/usr/bin/env ruby

require "newt"

def disableCallback(cs, en)
  #STDERR.print cs.get, "\n"
  if cs.get == ' '
	en.set_flags(Newt::FLAG_DISABLED, Newt::FLAGS_RESET)
  else
	en.set_flags(Newt::FLAG_DISABLED, Newt::FLAGS_SET)
  end
  Newt::Screen.refresh()
end

Newt::Screen.new

Newt::Screen.draw_roottext(0, 0, "Newt �ƥ��ȥץ������")
Newt::Screen.push_helpline("")
Newt::Screen.draw_roottext(-50, 0, "�롼�ȥƥ�����")

Newt::Screen.open_window(2, 2, 30, 10, "�����ܤΥ�����ɥ�")
Newt::Screen.open_window(10, 5, 65, 16, "������ɥ���")

f = Newt::Form.new
chklist = Newt::Form.new

b1 = Newt::Button.new(3, 1, "��λ")
b2 = Newt::Button.new(18, 1, "����")
r1 = Newt::RadioButton.new(20, 10, "����裱", 0, nil)
r2 = Newt::RadioButton.new(20, 11, "����裲", 1, r1)
r3 = Newt::RadioButton.new(20, 12, "����裳", 0, r2)
rsf = Newt::Form.new
#[r1, r2, r3].each {|i| rsf.add(i)}
rsf.add(r1, r2, r3)
rsf.set_background(Newt::COLORSET_CHECKBOX)

Newt::Screen.refresh

cs = []
for i in 0...10
  buf = sprintf("�����å� %d", i)
  cs[i] = Newt::Checkbox.new(3, 10 + i, buf, ' ', nil)
  chklist.add(cs[i])
end

l1 = Newt::Label.new(3, 6, "��������:")
l2 = Newt::Label.new(3, 7, "����������:")
l3 = Newt::Label.new(3, 8, "�ҥɥ���:")
e1 = Newt::Entry.new(12, 6, "", 20, 0);
e2 = Newt::Entry.new(12, 7, "ɸ��", 20, Newt::FLAG_SCROLL)
e3 = Newt::Entry.new(12, 8, "", 20, Newt::FLAG_HIDDEN)

#cs[0].callback( proc { print "Hello!!\n" } )
cs[0].callback( proc { disableCallback(cs[0], e1) } )

scale = Newt::Scale.new(3, 14, 32, 100)

chklist.set_height(3)

f.add(b1, b2, l1, l2, l3, e1, e2, e3, chklist)
f.add(rsf, scale)

lb = Newt::Listbox.new(45, 1, 6, Newt::FLAG_MULTIPLE | Newt::FLAG_BORDER |
					   Newt::FLAG_SCROLL)
lb.append("������", 1)
lb.append("������", 2)
lb.append("������", 3)
lb.append("������", 4)
lb.append("������", 6)
lb.append("������", 7)
lb.append("������", 8)
lb.append("������", 9)
lb.append("��������", 10)

lb.insert("������", 5, 4)
lb.insert("��������", 11, 10)
lb.delete(11)

t = Newt::Textbox.new(45, 10, 17, 5, Newt::FLAG_WRAP)
t.set_text("����ϥƥ����ȤΥ���ץ�Ǥ���\n�����ɽ������Ƥ��ޤ�����\n�����ñ�ȹԤǤ���\n�����ɽ������ƤϤ����ޤ���")

f.add(lb, t)

Newt::Screen.refresh

begin
  answer = f.run()

  #p answer
  #p b2
  if answer == b2

	scale.set(e1.get.to_i)
	Newt::Screen.refresh
	answer = nil
  end
end while answer == nil

#selectedList = Newt::Listbox.get_selection(lb, &numsel)
selectedList = true
numsel = 0

Newt::Screen.pop_window()
Newt::Screen.pop_window()

Newt::Screen.finish

printf "got string 1: %s\n", e1.get
printf "got string 2: %s\n", e2.get
printf "got string 3: %s\n", e3.get

if selectedList
  print "\nSelected listbox items:\n"
  for i in 0...numsel
	#puts selectedList[i]
  end
end