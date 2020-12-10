import re

def process_date(date,state):

    month = {	'01':'Jan',
		'02':'Feb',
		'03':'Mar',
		'04':'Apr',
		'05':'May',
		'06':'Jun',
		'07':'Jul',
		'08':'Aug',
		'09':'Sep',
		'10':'Oct',
		'11':'Nov',
		'12':'Dec'		
                }

    # strip for whitespaces    
    date = date.rstrip()

    if state == 0:
        # for api

        # date = "2020-07-09T14:10:00Z"
        date = date[:10]
        # date = "2020-07-09"
        date = date.split('-')
        # date = ['2020','07','09']
        date = date[::-1]

        # convert int to month
        date[1] = month[date[1]]
        # date = ['09','Jul','2020']

        date = ' '.join(date)
        # date = '09 Jul 2020'
        return date

    elif state == 1:
        # for dte

        # date = 'July 09, 2020'
        date = date.replace(',','')
        # date = 'July 09 2020'
        date = date.split()
        # date = ['July','09','2020']

        # shorten the month
        date[0] = date[0][:3]

        date = [date[1],date[0],date[2]]
        # date = ['09','July','2020']

        date = ' '.join(date)
        # date = '09 Jul 2020'
        return date

    elif state == 2:
        
        # date = '09/07/2020'

        date = date.split('/')
        # date = ['09','07','2020']
        date[1] = month[date[1]]
        # date = ['09','July','2020']
        date = ' '.join(date)
        # date = '09 Jul 2020'

        if date =='31 Apr 2020':
            date ='30 Apr 2020'
        return date

    
def process_text(text):
    
    text = re.sub('\\r','',text)
    text = re.sub('\\n','',text)
    text = text.rstrip().lstrip()
    return text


def only_relevant(tup):
    # takes a tuple (news, class=0 or 1) and returns only 1s
    if tup[1]:
        return True
    else:
        return False
